"
A SRMeshSourceRaw provides raw access to the data arrays.
This data is stored in the image and will thus persist through restarts without any external dependencies.
"
Class {
	#name : #SRMeshSourceRaw,
	#superclass : #SRMeshSource,
	#instVars : [
		'colors',
		'elementCount',
		'indices',
		'normals',
		'texcoords',
		'vertices',
		'isEditable'
	],
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : 'lege 7/6/2026 18:52'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/7/2026 16:29'
}
SRMeshSourceRaw class >> colorsClass [

	^ ByteArray
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/7/2026 18:22'
}
SRMeshSourceRaw class >> indicesClass [

	^ DoubleByteArray
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/7/2026 16:30'
}
SRMeshSourceRaw class >> normalsClass [

	^ Float32Array
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/9/2026 17:15'
}
SRMeshSourceRaw class >> pointerFor: anObject [

	self assert: anObject notNil.
	
	anObject pin.
	^ AlienStub forOop
		oopAt: 1 put: anObject;
		addressField
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/7/2026 16:29'
}
SRMeshSourceRaw class >> texcoordsClass [

	^ Float32Array
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/7/2026 16:29'
}
SRMeshSourceRaw class >> verticesClass [

	^ Float32Array
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:56'
}
SRMeshSourceRaw >> colors [

	^ colors
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/9/2026 17:14'
}
SRMeshSourceRaw >> colors: aByteArray [

	self assert: isEditable.
	colors := aByteArray.
]

{
	#category : #mesh,
	#'squeak_changestamp' : 'lege 7/9/2026 17:20'
}
SRMeshSourceRaw >> createInternalMesh [

	| newMesh |

	newMesh := RlMesh new
		vertexCount: self elementCount;
		triangleCount: self triangleCount;
		vertices: (self class pointerFor: vertices);
		normals: (self class pointerFor: normals);
		texcoords: (self class pointerFor: texcoords).
	indices ifNotNil: [newMesh indices: (self class pointerFor: indices)].
	colors ifNotNil: [newMesh colors: (self class pointerFor: colors)].
	^ newMesh
]

{
	#category : #mesh,
	#'squeak_changestamp' : 'lege 7/7/2026 18:17'
}
SRMeshSourceRaw >> editDo: aBlock [

	"Use this method to modify the contents of the mesh source.
	This ensures that dependents of the mesh are notified after the block finishes."
	
	isEditable := true.
	aBlock cull: self.
	isEditable := false.
	self notifyMeshChanged.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/7/2026 19:32'
}
SRMeshSourceRaw >> elementCount [

	^ self vertices size / (3 * 4)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:56'
}
SRMeshSourceRaw >> indices [

	^ indices
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/9/2026 17:14'
}
SRMeshSourceRaw >> indices: aWordArray [

	self assert: isEditable.
	indices := aWordArray.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 7/7/2026 17:32'
}
SRMeshSourceRaw >> initialize [

	super initialize.
	isEditable := false.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:56'
}
SRMeshSourceRaw >> normals [

	^ normals
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/9/2026 17:14'
}
SRMeshSourceRaw >> normals: aFloat32Array [

	self assert: isEditable.
	normals := aFloat32Array
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/6/2026 18:55'
}
SRMeshSourceRaw >> onCacheInvalidated [

	"do nothing"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:56'
}
SRMeshSourceRaw >> texcoords [

	^ texcoords
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/9/2026 17:15'
}
SRMeshSourceRaw >> texcoords: aFloat32Array [

	self assert: isEditable.
	texcoords := aFloat32Array.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/7/2026 19:33'
}
SRMeshSourceRaw >> triangleCount [

	^ (self indices ifNotNil: [:i | i size / 2] ifNil: [self elementCount]) / 3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/6/2026 18:56'
}
SRMeshSourceRaw >> vertices [

	^ vertices
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/9/2026 17:15'
}
SRMeshSourceRaw >> vertices: aFloat32Array [

	self assert: isEditable.
	vertices := aFloat32Array.
]
