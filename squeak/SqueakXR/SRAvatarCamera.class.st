Class {
	#name : #SRAvatarCamera,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/23/2026 16:53'
}
SRAvatarCamera >> cameraTransformUpdated: cameraTransform [

	| quat |
	quat := cameraTransform rotation.
	self transform
		setFromQuaternion: (Quaternion a: quat w b: quat x c: quat y d: quat z);
		setTranslation: cameraTransform translation asVector3.
	self transform
		a13: self transform a13 negated;
		a23: self transform a23 negated;
		a33: self transform a33 negated.
	self localTransformDirty.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/21/2026 18:09'
}
SRAvatarCamera >> onWorldChanged: oldWorld [

	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world addDependent: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/23/2026 10:30'
}
SRAvatarCamera >> update: aSymbol with: anObject [

	aSymbol = #cameraTransformUpdated ifTrue: [self cameraTransformUpdated: anObject].
]
