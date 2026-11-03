Class {
	#name : #XrQuaternionf,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf class >> fields [

	^ #(
		(x 'float')
		(y 'float')
		(z 'float')
		(w 'float')
	)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf >> a [ ^ self w
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf >> b [ ^ self x
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf >> c [ ^ self y
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf >> d [ ^ self z
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrQuaternionf >> squaredLength [ ^ self w squared + self x squared + self y squared + self z squared
]
