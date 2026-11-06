"
A SRMeshSourceFile loads mesh data from a file.
"
Class {
	#name : #SRMeshSourceFile,
	#superclass : #SRMeshSource,
	#instVars : [
		'path'
	],
	#category : #'SqueakXR-Graphics-Mesh',
	#'squeak_changestamp' : 'lege 7/6/2026 18:33'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 18:32'
}
SRMeshSourceFile class >> path: aString [

	^ self new path: aString
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:25'
}
SRMeshSourceFile >> createInternalMesh [

	| model |
	self assert: path notNil.
	model := Raylib loadModelFileName: self path.
	model meshCount = 0 ifTrue: [^ self error: 'Could not load a mesh from ', self path].
	^ model meshes
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 18:32'
}
SRMeshSourceFile >> onCacheInvalidated [

	"noop"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 18:33'
}
SRMeshSourceFile >> path [

	^ path
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 18:33'
}
SRMeshSourceFile >> path: aString [

	path := aString.
	self notifyMeshChanged.
]
