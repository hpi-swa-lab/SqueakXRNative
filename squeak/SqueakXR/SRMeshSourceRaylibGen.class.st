Class {
	#name : #SRMeshSourceRaylibGen,
	#superclass : #SRMeshSource,
	#instVars : [
		'generatorMessage'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:21'
}
SRMeshSourceRaylibGen class >> cylinderRadius: radius height: height slices: slices [

	^ self new cylinderRadius: radius height: height slices: slices
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:10'
}
SRMeshSourceRaylibGen class >> knotRadius: radius size: size radSeg: radSeg sides: sides [

	^ self new knotRadius: radius size: size radSeg: radSeg sides: sides
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 13:56'
}
SRMeshSourceRaylibGen class >> planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections [

	^ self new planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:16'
}
SRMeshSourceRaylibGen >> createInternalMesh [

	^ self generatorMessage ifNotNil: [:message | message value]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:22'
}
SRMeshSourceRaylibGen >> cylinderRadius: radius height: height slices: slices [

	self generatorMessage: (
		MessageSend
			receiver: Raylib
			selector: #genMeshCylinderRadius:height:slices:
			arguments: {radius. height. slices}).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:15'
}
SRMeshSourceRaylibGen >> generatorMessage [

	^ generatorMessage
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:14'
}
SRMeshSourceRaylibGen >> generatorMessage: aMessageSend [

	generatorMessage := aMessageSend.
	self notifyMeshChanged.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:13'
}
SRMeshSourceRaylibGen >> knotRadius: radius size: size radSeg: radSeg sides: sides [

	self generatorMessage: (
		MessageSend
			receiver: Raylib
			selector: #genMeshKnotRadius:size:radSeg:sides:
			arguments: {radius. size. radSeg. sides}).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 14:08'
}
SRMeshSourceRaylibGen >> onCacheInvalidated [

	"noop"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 13:57'
}
SRMeshSourceRaylibGen >> planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections [

	self generatorMessage: (
		MessageSend
			receiver: Raylib
			selector: #genMeshPlaneWidth:length:resX:resZ:
			arguments: {width. length. widthSections. lengthSections}).
]
