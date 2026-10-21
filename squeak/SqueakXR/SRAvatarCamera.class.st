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
	#'squeak_changestamp' : 'MCPServer 8/10/2026 17:33'
}
SRAvatarCamera >> onWorldChanged: oldWorld [

	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world ifNotNil: [:each | each addDependent: self].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/23/2026 10:30'
}
SRAvatarCamera >> update: aSymbol with: anObject [

	aSymbol = #cameraTransformUpdated ifTrue: [self cameraTransformUpdated: anObject].
]
