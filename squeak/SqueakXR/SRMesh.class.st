"
An SRMesh owns a GPU-resident triangle mesh whose CPU-side authoritative data lives in Squeak ByteArray ivars so it survives image save/restart.

Data flow:
  ByteArrays (vertexBytes, normalBytes, texcoordBytes, indexBytes)  <-- canonical, image-persistent
    |
    v  (lazy, on first GPU access after construction or restart)
  ExternalAddress buffers (vertices, normals, texcoords, indices)   <-- off-heap, GPU-readable
    |
    v  (UploadMesh)
  GPU VBOs (vaoId, vboId on the RlMesh struct)                       <-- handles transient

Per-frame mutations write to the external buffer (fast, no GC pressure). On shutDown: the external buffer is copied back into the ByteArray so the latest state persists. On startUp: external pointers are nilled; next access re-allocates and re-uploads.

Class-side LiveInstances is a WeakSet of all SRMesh instances. The class hooks Smalltalk's shutDown/startUp list to manage GPU lifecycle for all live meshes.

ivars:
  rlMesh           the RlMesh ExternalStructure (rebuilt on restart)
  vertexBytes      ByteArray, vertexCount * 3 * 4 bytes (3 floats each)
  normalBytes      ByteArray, vertexCount * 3 * 4 bytes
  texcoordBytes    ByteArray, vertexCount * 2 * 4 bytes
  indexBytes       ByteArray, triangleCount * 3 * 2 bytes (uint16), or nil
  vertices         ExternalAddress mirror of vertexBytes for FFI (transient)
  normals          ExternalAddress mirror of normalBytes (transient)
  texcoords        ExternalAddress mirror of texcoordBytes (transient)
  indices          ExternalAddress mirror of indexBytes (transient)
  vertexCount      SmallInteger
  triangleCount    SmallInteger
  cols, rows       grid dimensions (nil for non-grid meshes)
  isDynamic        true if UploadMesh should be called with dynamic=true
  isUploaded       true once UploadMesh has run (transient -- nil on restart)
"
Class {
	#name : #SRMesh,
	#superclass : #Object,
	#instVars : [
		'rlMesh',
		'vertexBytes',
		'normalBytes',
		'texcoordBytes',
		'indexBytes',
		'colorBytes',
		'vertices',
		'normals',
		'texcoords',
		'indices',
		'colors',
		'vertexCount',
		'triangleCount',
		'cols',
		'rows',
		'isDynamic',
		'isUploaded'
	],
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:33'
}
SRMesh class >> grid: aCols by: aRows extent: aPoint [
	"Build a flat XY grid mesh centered at origin in the X/Z plane (Y is up). aCols and aRows are vertex counts along each axis."

	^ self new initializeGridCols: aCols rows: aRows extent: aPoint
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:47'
}
SRMesh class >> vertexBytes: vBytes normalBytes: nBytes texcoordBytes: tBytes colorBytes: cBytes indexBytes: iBytes vertexCount: vCount triangleCount: tCount [
	"General constructor for a non-grid mesh. Caller supplies already-laid-out ByteArrays.
	 vBytes: vCount * 3 * 4 bytes (xyz floats)
	 nBytes: vCount * 3 * 4 bytes (xyz floats)
	 tBytes: vCount * 2 * 4 bytes (uv floats)   -- may be a zero-filled placeholder
	 cBytes: vCount * 4 bytes (rgba uchar)      -- may be nil for no per-vertex color
	 iBytes: tCount * 3 * 2 bytes (uint16)      -- may be nil for non-indexed mesh"

	^ self new
		initializeVertexBytes: vBytes
		normalBytes: nBytes
		texcoordBytes: tBytes
		colorBytes: cBytes
		indexBytes: iBytes
		vertexCount: vCount
		triangleCount: tCount
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:47'
}
SRMesh >> buildAndUploadRlMesh [
	"Materialize fresh external buffers from canonical ByteArrays, build the RlMesh struct, upload to GPU. Returns the RlMesh ready for DrawMesh. Cached by the renderer."

	rlMesh := RlMesh new.
	vertices := ExternalAddress allocate: vertexBytes size.
	self writeBytes: vertexBytes to: vertices.
	normals := ExternalAddress allocate: normalBytes size.
	self writeBytes: normalBytes to: normals.
	texcoords := ExternalAddress allocate: texcoordBytes size.
	self writeBytes: texcoordBytes to: texcoords.
	indexBytes ifNotNil: [
		indices := ExternalAddress allocate: indexBytes size.
		self writeBytes: indexBytes to: indices].
	colorBytes ifNotNil: [
		colors := ExternalAddress allocate: colorBytes size.
		self writeBytes: colorBytes to: colors].
	rlMesh vertexCount: vertexCount.
	rlMesh triangleCount: triangleCount.
	rlMesh vertices: vertices.
	rlMesh normals: normals.
	rlMesh texcoords: texcoords.
	indices ifNotNil: [rlMesh indices: indices].
	colors ifNotNil: [rlMesh colors: colors].
	Raylib uploadMesh: rlMesh dynamic: isDynamic.
	isUploaded := true.
	^ rlMesh
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:47'
}
SRMesh >> buildRlMesh [
	"Construct the RlMesh struct and point its float pointers at our external buffers. Requires ensureExternalBuffers first. Upload is deferred to first #internalMesh access."

	self ensureExternalBuffers.
	rlMesh := RlMesh new.
	rlMesh vertexCount: vertexCount.
	rlMesh triangleCount: triangleCount.
	rlMesh vertices: vertices.
	rlMesh normals: normals.
	rlMesh texcoords: texcoords.
	indices ifNotNil: [rlMesh indices: indices].
	colors ifNotNil: [rlMesh colors: colors].
	isUploaded := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> cols [
	^ cols
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:21'
}
SRMesh >> currentRlMesh [
	"Return the live RlMesh from the current world renderer's cache, building+uploading on first miss. Returns nil if no renderer is available (pre-GL or no world). SRPlane-style pattern: the renderer cache is the source of truth for GPU state, so a stale local rlMesh ivar (e.g. after image save+restart) is never consulted."

	| w r |
	w := SRWorld current.
	w ifNil: [^ nil].
	r := w renderer.
	r ifNil: [^ nil].
	^ self internalMeshFor: r
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:47'
}
SRMesh >> ensureExternalBuffers [
	"Allocate external mirrors of the ByteArrays if they are not yet materialized (e.g. fresh construction or first access after restart). Copy ByteArray contents into the external buffers when (re)allocating."

	vertices ifNil: [
		vertices := ExternalAddress allocate: vertexBytes size.
		self writeBytes: vertexBytes to: vertices].
	normals ifNil: [
		normals := ExternalAddress allocate: normalBytes size.
		self writeBytes: normalBytes to: normals].
	texcoords ifNil: [
		texcoords := ExternalAddress allocate: texcoordBytes size.
		self writeBytes: texcoordBytes to: texcoords].
	(indexBytes notNil and: [indices isNil]) ifTrue: [
		indices := ExternalAddress allocate: indexBytes size.
		self writeBytes: indexBytes to: indices].
	(colorBytes notNil and: [colors isNil]) ifTrue: [
		colors := ExternalAddress allocate: colorBytes size.
		self writeBytes: colorBytes to: colors]
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:38'
}
SRMesh >> flushNormals [
	"Push the CPU normal buffer to GPU VBO 2. See flushVertices for rationale."

	self currentRlMesh ifNil: [^ self].
	Raylib
		updateMeshBufferMesh: rlMesh
		index: 2
		data: normals
		dataSize: vertexCount * 3 * 4
		offset: 0
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:38'
}
SRMesh >> flushVertices [
	"Push the CPU vertex buffer to GPU VBO 0. Calls currentRlMesh first to ensure ivars are populated for the current session (rebuilds via cache miss after image restart). Silently bails if no renderer is available yet."

	self currentRlMesh ifNil: [^ self].
	Raylib
		updateMeshBufferMesh: rlMesh
		index: 0
		data: vertices
		dataSize: vertexCount * 3 * 4
		offset: 0
]

{
	#category : #grid,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> heightAtRow: r col: c [
	^ self vertexBuffer floatAt: (r * cols + c) * 12 + 5
]

{
	#category : #grid,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> heightAtRow: r col: c put: y [
	self vertexBuffer floatAt: (r * cols + c) * 12 + 5 put: y asFloat
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:43'
}
SRMesh >> initializeGridCols: aCols rows: aRows extent: aPoint [
	"Allocate canonical ByteArrays and populate them with a flat grid in the X/Z plane. The ByteArrays are image-persistent; on image restart we rebuild external buffers from them via #onCacheInvalidated and lazy materialization."

	| dx dz xCenter zCenter dummy |
	cols := aCols.
	rows := aRows.
	vertexCount := cols * rows.
	triangleCount := (cols - 1) * (rows - 1) * 2.
	isDynamic := true.
	isUploaded := false.

	vertexBytes := ByteArray new: vertexCount * 3 * 4.
	normalBytes := ByteArray new: vertexCount * 3 * 4.
	texcoordBytes := ByteArray new: vertexCount * 2 * 4.
	indexBytes := ByteArray new: triangleCount * 3 * 2.

	dx := aPoint x asFloat / (cols - 1).
	dz := aPoint y asFloat / (rows - 1).
	xCenter := aPoint x asFloat / 2.
	zCenter := aPoint y asFloat / 2.

	"Materialize external buffers temporarily so we can populate via floatAt:put:."
	self ensureExternalBuffers.

	0 to: rows - 1 do: [:r |
		0 to: cols - 1 do: [:c |
			| k vOff nOff tOff |
			k := r * cols + c.
			vOff := k * 12.
			nOff := k * 12.
			tOff := k * 8.
			vertices floatAt: vOff + 1 put: c * dx - xCenter.
			vertices floatAt: vOff + 5 put: 0.0.
			vertices floatAt: vOff + 9 put: r * dz - zCenter.
			normals floatAt: nOff + 1 put: 0.0.
			normals floatAt: nOff + 5 put: 1.0.
			normals floatAt: nOff + 9 put: 0.0.
			texcoords floatAt: tOff + 1 put: c asFloat / (cols - 1).
			texcoords floatAt: tOff + 5 put: r asFloat / (rows - 1)]].

	dummy := 0.
	0 to: rows - 2 do: [:r |
		0 to: cols - 2 do: [:c |
			| a b cc d idxBase |
			a := r * cols + c.
			b := r * cols + c + 1.
			cc := (r + 1) * cols + c.
			d := (r + 1) * cols + c + 1.
			idxBase := dummy * 6.
			indices unsignedShortAt: idxBase + 1 put: a.
			indices unsignedShortAt: idxBase + 3 put: cc.
			indices unsignedShortAt: idxBase + 5 put: b.
			indices unsignedShortAt: idxBase + 7 put: b.
			indices unsignedShortAt: idxBase + 9 put: cc.
			indices unsignedShortAt: idxBase + 11 put: d.
			dummy := dummy + 2]].

	"Copy the external content into the canonical ByteArrays once at construction. Per-frame mutations write to the external buffers only -- the canonical bytes hold the initial geometry, sufficient for restart-time reconstruction (per-frame state will be regenerated by step:)."
	self syncExternalToBytes.

	self buildRlMesh
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:48'
}
SRMesh >> initializeVertexBytes: vBytes normalBytes: nBytes texcoordBytes: tBytes colorBytes: cBytes indexBytes: iBytes vertexCount: vCount triangleCount: tCount [
	"General initializer. ByteArrays are stored as the canonical (image-persistent) backing; external buffers + RlMesh struct are built lazily by buildRlMesh."

	vertexBytes := vBytes.
	normalBytes := nBytes.
	texcoordBytes := tBytes.
	colorBytes := cBytes.
	indexBytes := iBytes.
	vertexCount := vCount.
	triangleCount := tCount.
	cols := nil.
	rows := nil.
	isDynamic := true.
	isUploaded := false.
	self buildRlMesh
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> internalMesh [
	"Lazily materialize external buffers and upload to the GPU. Returns the RlMesh struct ready for DrawMesh. Cheap once the mesh is uploaded -- just returns the cached struct."

	rlMesh ifNil: [self buildRlMesh].
	isUploaded ifFalse: [self upload].
	^ rlMesh
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRMesh >> internalMeshFor: aSRRenderer [
	"Return the RlMesh struct, building and uploading if the renderer cache doesn't already have it. Cache miss happens once per renderer lifetime (and once per image-restart). All GPU work is gated by this call, which only happens at render time -- when GL is alive."

	^ aSRRenderer cacheAt: self ifAbsentPut: [self buildAndUploadRlMesh]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRMesh >> isUploaded [
	^ isUploaded ifNil: [false]
]

{
	#category : #buffers,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:38'
}
SRMesh >> normalBuffer [
	"Raw access to the off-heap normal buffer. See vertexBuffer."

	self currentRlMesh ifNil: [^ nil].
	^ normals
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:29'
}
SRMesh >> onCacheInvalidated [
	"Renderer cache is being cleared. The cache held our RlMesh struct + external buffers + GPU VAO. They go away with the cache. Next render rebuilds via cache miss. We do NOTHING here -- no GL access, safe to call before GL is up."
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:33'
}
SRMesh >> readBytesFrom: anExternalAddress count: nBytes [
	"Copy nBytes from off-heap memory into a fresh ByteArray. Image-persistent."

	| ba |
	ba := ByteArray new: nBytes.
	1 to: nBytes do: [:i | ba at: i put: (anExternalAddress byteAt: i)].
	^ ba
]

{
	#category : #grid,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> recomputeGridNormals [
	"Smooth normals via central differences on Y. Caller should #flushNormals afterwards."

	| dx dz xStep zStep vBuf nBuf |
	cols ifNil: [^ self error: 'Not a grid mesh'].
	vBuf := self vertexBuffer.
	nBuf := self normalBuffer.
	dx := (vBuf floatAt: 12 + 1) - (vBuf floatAt: 1).
	dz := (vBuf floatAt: cols * 12 + 9) - (vBuf floatAt: 9).
	xStep := dx * 2.
	zStep := dz * 2.
	0 to: rows - 1 do: [:r |
		0 to: cols - 1 do: [:c |
			| hL hR hD hU dyX dyZ nx ny nz invLen k nOff |
			hL := self heightAtRow: r col: (c - 1 max: 0).
			hR := self heightAtRow: r col: (c + 1 min: cols - 1).
			hD := self heightAtRow: (r - 1 max: 0) col: c.
			hU := self heightAtRow: (r + 1 min: rows - 1) col: c.
			dyX := (hR - hL) / xStep.
			dyZ := (hU - hD) / zStep.
			nx := dyX negated.
			ny := 1.0.
			nz := dyZ negated.
			invLen := 1.0 / ((nx * nx + (ny * ny) + (nz * nz)) sqrt).
			k := r * cols + c.
			nOff := k * 12.
			nBuf floatAt: nOff + 1 put: nx * invLen.
			nBuf floatAt: nOff + 5 put: ny * invLen.
			nBuf floatAt: nOff + 9 put: nz * invLen]]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> rows [
	^ rows
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 11:47'
}
SRMesh >> syncExternalToBytes [
	"Copy current external buffer contents into the canonical ByteArrays. Called once at construction; can also be called manually to checkpoint the latest state if you need restart-survivable mutated geometry."

	vertexBytes := self readBytesFrom: vertices count: vertexCount * 3 * 4.
	normalBytes := self readBytesFrom: normals count: vertexCount * 3 * 4.
	texcoordBytes := self readBytesFrom: texcoords count: vertexCount * 2 * 4.
	indices ifNotNil: [
		indexBytes := self readBytesFrom: indices count: triangleCount * 3 * 2].
	colors ifNotNil: [
		colorBytes := self readBytesFrom: colors count: vertexCount * 4]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRMesh >> triangleCount [
	^ triangleCount
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> upload [
	"Push vertex data to GPU and obtain VAO/VBO ids. Uses dynamic=true so subsequent UpdateMeshBuffer calls are allowed."

	Raylib uploadMesh: rlMesh dynamic: isDynamic.
	isUploaded := true
]

{
	#category : #buffers,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:38'
}
SRMesh >> vertexBuffer [
	"Raw access to the off-heap vertex buffer for direct mutation via floatAt:put:. Calls currentRlMesh first to ensure the local vertices ivar is populated for the current session (rebuilds via cache miss after image restart, which (re)allocates the ExternalAddress and reassigns the ivar inside buildAndUploadRlMesh). Returns nil if no renderer is available yet."

	self currentRlMesh ifNil: [^ nil].
	^ vertices
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> vertexCount [
	^ vertexCount
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:33'
}
SRMesh >> writeBytes: aByteArray to: anExternalAddress [
	"Copy a ByteArray's contents to off-heap memory."

	1 to: aByteArray size do: [:i | anExternalAddress byteAt: i put: (aByteArray at: i)]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> xAtCol: c [
	^ self vertexBuffer floatAt: c * 12 + 1
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:34'
}
SRMesh >> zAtRow: r [
	^ self vertexBuffer floatAt: r * cols * 12 + 9
]
