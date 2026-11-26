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
