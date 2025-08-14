Class {
	#name : #XrQuaternionf,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrQuaternionf class >> fields [

	^ #(
		(x 'float')
		(y 'float')
		(z 'float')
		(w 'float')
	)
]

{ #category : #'as yet unclassified' }
XrQuaternionf >> a [ ^ self w
]

{ #category : #'as yet unclassified' }
XrQuaternionf >> b [ ^ self x
]

{ #category : #'as yet unclassified' }
XrQuaternionf >> c [ ^ self y
]

{ #category : #'as yet unclassified' }
XrQuaternionf >> d [ ^ self z
]

{ #category : #'as yet unclassified' }
XrQuaternionf >> squaredLength [ ^ self w squared + self x squared + self y squared + self z squared
]
