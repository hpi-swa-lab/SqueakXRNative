"
A SRMeshSourceFile loads mesh data from a file.
"
Class {
	#name : #SRMeshSourceFile,
	#superclass : #SRMeshSource,
	#instVars : [
		'path'
	],
	#category : #'SqueakXR-Core',
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
	#'squeak_changestamp' : 'lege 7/15/2026 18:43'
}
SRMeshSourceFile >> createInternalMesh [

	self assert: path notNil.
	^ (Raylib loadModelFileName: self path) meshes
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
