Class {
	#name : #SRAvatarCamera,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:52'
}
SRAvatarCamera >> cameraTransformUpdated: cameraTransform [

	| quat |
	quat := cameraTransform rotation.
	self transform
		setFromQuaternion: (Quaternion a: quat w b: quat x c: quat y d: quat z);
		setTranslation: cameraTransform translation asVector3.
	self localTransformDirty.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:23'
}
SRAvatarCamera >> initialize [

	super initialize.

	self addChild: SRAudioEars new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 17:33'
}
SRAvatarCamera >> onWorldChanged: oldWorld [

	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world ifNotNil: [:each | each addDependent: self].
]

{
	#category : #updating,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRAvatarCamera >> update: aSymbol with: anObject [
	"The head pose belongs to the world avatar only."
	(aSymbol = #cameraTransformUpdated and: [self parent == self world avatar])
		ifTrue: [self cameraTransformUpdated: anObject]
]
