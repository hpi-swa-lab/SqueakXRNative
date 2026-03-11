Extension { #name : #Quaternion }

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 1/22/2026 16:44'
}
Quaternion >> deltaTo: aQuaternion [

	^ aQuaternion * self inverse
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 1/22/2026 16:37'
}
Quaternion >> inverse [

	"assumption: the quaternion is normalized"
	^ Quaternion
		a: self a
		b: self b negated
		c: self c negated
		d: self d negated
]
