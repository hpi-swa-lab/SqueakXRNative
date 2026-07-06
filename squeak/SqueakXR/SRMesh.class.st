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
		'internalMesh',
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
	#'squeak_changestamp' : 'lege 7/6/2026 18:11'
}
SRMesh >> buildAndUploadRlMesh [

	internalMesh := RlMesh new.
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
	internalMesh vertexCount: vertexCount.
	internalMesh triangleCount: triangleCount.
	internalMesh vertices: vertices.
	internalMesh normals: normals.
	internalMesh texcoords: texcoords.
	indices ifNotNil: [internalMesh indices: indices].
	colors ifNotNil: [internalMesh colors: colors].
	Raylib uploadMesh: internalMesh dynamic: isDynamic.
	isUploaded := true.
	^ internalMesh
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 7/6/2026 18:11'
}
SRMesh >> buildRlMesh [

	self ensureExternalBuffers.
	internalMesh := RlMesh new.
	internalMesh vertexCount: vertexCount.
	internalMesh triangleCount: triangleCount.
	internalMesh vertices: vertices.
	internalMesh normals: normals.
	internalMesh texcoords: texcoords.
	indices ifNotNil: [internalMesh indices: indices].
	colors ifNotNil: [internalMesh colors: colors].
	isUploaded := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:16'
}
SRMesh >> cols [

	^ cols
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> ensureExternalBuffers [

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
	#'squeak_changestamp' : 'lege 7/6/2026 18:12'
}
SRMesh >> flushNormals [

	self hasInternalMesh ifFalse: [^ self].
	Raylib
		updateMeshBufferMesh: internalMesh
		index: 2
		data: normals
		dataSize: vertexCount * 3 * 4
		offset: 0
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'lege 7/6/2026 18:13'
}
SRMesh >> flushVertices [

	self hasInternalMesh ifFalse: [^ self].
	Raylib
		updateMeshBufferMesh: internalMesh
		index: 0
		data: vertices
		dataSize: vertexCount * 3 * 4
		offset: 0
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:12'
}
SRMesh >> hasInternalMesh [

	^ internalMesh notNil
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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> initializeGridCols: aCols rows: aRows extent: aPoint [

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

	self syncExternalToBytes.
	self buildRlMesh
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> initializeVertexBytes: vBytes normalBytes: nBytes texcoordBytes: tBytes colorBytes: cBytes indexBytes: iBytes vertexCount: vCount triangleCount: tCount [

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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> internalMeshFor: aSRRenderer [

	^ aSRRenderer cacheAt: self ifAbsentPut: [self buildAndUploadRlMesh]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:16'
}
SRMesh >> isUploaded [

	^ isUploaded ifNil: [false]
]

{
	#category : #buffers,
	#'squeak_changestamp' : 'lege 7/6/2026 18:13'
}
SRMesh >> normalBuffer [

	self hasInternalMesh ifFalse: [^ self].
	^ normals
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> onCacheInvalidated [
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> readBytesFrom: anExternalAddress count: nBytes [

	| ba |
	ba := ByteArray new: nBytes.
	1 to: nBytes do: [:i | ba at: i put: (anExternalAddress byteAt: i)].
	^ ba
]

{
	#category : #grid,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
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
	#'squeak_changestamp' : 'lege 7/6/2026 18:15'
}
SRMesh >> rows [

	^ rows
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> syncExternalToBytes [

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
	#'squeak_changestamp' : 'lege 7/6/2026 18:15'
}
SRMesh >> triangleCount [

	^ triangleCount
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'lege 7/6/2026 18:11'
}
SRMesh >> upload [

	Raylib uploadMesh: internalMesh dynamic: isDynamic.
	isUploaded := true
]

{
	#category : #buffers,
	#'squeak_changestamp' : 'lege 7/6/2026 18:13'
}
SRMesh >> vertexBuffer [

	self hasInternalMesh ifFalse: [^ self].
	^ vertices
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:15'
}
SRMesh >> vertexCount [

	^ vertexCount
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 14:58'
}
SRMesh >> writeBytes: aByteArray to: anExternalAddress [

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
