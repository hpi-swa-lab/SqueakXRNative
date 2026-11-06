Class {
	#name : #SRMeshSourceRawTest,
	#superclass : #TestCase,
	#instVars : [
		'source'
	],
	#category : #'SqueakXR-Tests-Core'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:29'
}
SRMeshSourceRawTest >> setUp [

	super setUp.
	source := SRMeshSourceRaw new.
	source editDo: [:each |
		each
			vertices: (Float32Array new: 9);
			normals: (Float32Array new: 9);
			texcoords: (Float32Array new: 6);
			colors: (ByteArray new: 12);
			indices: (DoubleByteArray withAll: #(0 1 2))].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:29'
}
SRMeshSourceRawTest >> testDetachingLeavesUnloadMeshNothingToFree [
	"UnloadMesh frees every CPU array it finds, and these are pinned Smalltalk objects."
	| mesh |
	mesh := source
		createMeshVertexCount: 3
		triangleCount: 1
		vertices: (source vertices pin; yourself)
		normals: (source normals pin; yourself)
		texcoords: (source texcoords pin; yourself)
		colors: (source colors pin; yourself)
		indices: (source indices pin; yourself).
	self deny: mesh vertices isNull.
	source detachArraysFrom: mesh.
	self assert: mesh vertices isNull.
	self assert: mesh normals isNull.
	self assert: mesh texcoords isNull.
	self assert: mesh colors isNull.
	self assert: mesh indices isNull.
	self assert: mesh tangents isNull.
	self assert: mesh boneIds isNull.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:29'
}
SRMeshSourceRawTest >> testUnloadDropsTheGpuCopy [

	| mesh |
	mesh := SRMesh withSource: source.
	mesh instVarNamed: 'internalMesh' put: RlMesh new.
	mesh unload.
	self assert: (mesh instVarNamed: 'internalMesh') isNil.
]
