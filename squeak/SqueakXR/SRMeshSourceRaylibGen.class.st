Class {
	#name : #SRMeshSourceRaylibGen,
	#superclass : #SRMeshSource,
	#instVars : [
		'generatorMessage'
	],
	#category : #'SqueakXR-Graphics-Mesh'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> coneRadius: radius height: height slices: slices [

	^ self new coneRadius: radius height: height slices: slices
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> cubeWidth: width height: height length: length [

	^ self new cubeWidth: width height: height length: length
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> cubicmapFile: aPath cubeSize: aVector3 [

	^ self new cubicmapFile: aPath cubeSize: aVector3
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> cylinderRadius: radius height: height slices: slices [

	^ self new cylinderRadius: radius height: height slices: slices
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> heightmapFile: aPath size: aVector3 [

	^ self new heightmapFile: aPath size: aVector3
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> hemiSphereRadius: radius rings: rings slices: slices [

	^ self new hemiSphereRadius: radius rings: rings slices: slices
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> knotRadius: radius size: size radSeg: radSeg sides: sides [

	^ self new knotRadius: radius size: size radSeg: radSeg sides: sides
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections [

	^ self new planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> polySides: sides radius: radius [

	^ self new polySides: sides radius: radius
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> sphereRadius: radius rings: rings slices: slices [

	^ self new sphereRadius: radius rings: rings slices: slices
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen class >> torusRadius: radius size: size radSeg: radSeg sides: sides [

	^ self new torusRadius: radius size: size radSeg: radSeg sides: sides
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> coneRadius: radius height: height slices: slices [

	self generateWith: #genMeshConeRadius:height:slices: arguments: {radius. height. slices}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/14/2026 11:16'
}
SRMeshSourceRaylibGen >> createInternalMesh [

	^ self generatorMessage ifNotNil: [:message | message value]
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> cubeWidth: width height: height length: length [

	self generateWith: #genMeshCubeWidth:height:length: arguments: {width. height. length}.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> cubicmapFile: aPath cubeSize: aVector3 [

	self generateFromImageFile: aPath with: #genMeshCubicmap:cubeSize: size: aVector3.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> cylinderRadius: radius height: height slices: slices [

	self generateWith: #genMeshCylinderRadius:height:slices: arguments: {radius. height. slices}.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> generateFromImageFile: aPath with: aSelector size: aVector3 [

	self generatorMessage: (
		MessageSend
			receiver: self
			selector: #meshFromImageFile:with:size:
			arguments: {aPath. aSelector. aVector3}).
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> generateWith: aSelector arguments: anArray [

	self generatorMessage: (
		MessageSend
			receiver: Raylib
			selector: aSelector
			arguments: anArray).
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
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> heightmapFile: aPath size: aVector3 [

	self generateFromImageFile: aPath with: #genMeshHeightmap:size: size: aVector3.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> hemiSphereRadius: radius rings: rings slices: slices [

	self generateWith: #genMeshHemiSphereRadius:rings:slices: arguments: {radius. rings. slices}.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> knotRadius: radius size: size radSeg: radSeg sides: sides [

	self generateWith: #genMeshKnotRadius:size:radSeg:sides: arguments: {radius. size. radSeg. sides}.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> meshFromImageFile: aPath with: aSelector size: aVector3 [

	| image |
	image := Raylib loadImageFileName: aPath.
	^ [Raylib perform: aSelector with: image with: aVector3 asRlVector]
		ensure: [Raylib unloadImage: image]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 14:08'
}
SRMeshSourceRaylibGen >> onCacheInvalidated [

	"noop"
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> planeWidth: width length: length widthSections: widthSections lengthSections: lengthSections [

	self generateWith: #genMeshPlaneWidth:length:resX:resZ: arguments: {width. length. widthSections. lengthSections}.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> polySides: sides radius: radius [

	self generateWith: #genMeshPolySides:radius: arguments: {sides. radius}.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> sphereRadius: radius rings: rings slices: slices [

	self generateWith: #genMeshSphereRadius:rings:slices: arguments: {radius. rings. slices}.
]

{
	#category : #shapes,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 18:11'
}
SRMeshSourceRaylibGen >> torusRadius: radius size: size radSeg: radSeg sides: sides [

	self generateWith: #genMeshTorusRadius:size:radSeg:sides: arguments: {radius. size. radSeg. sides}.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:28'
}
SRMeshSourceRaylibGen >> unloadInternalMesh: anRlMesh [

	Raylib unloadMesh: anRlMesh.
]
