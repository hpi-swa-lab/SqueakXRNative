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
	#'squeak_changestamp' : 'MCPServer (leo) 10/22/2026 18:15'
}
Quaternion class >> fromXrQuaternionf: anXrQuaternionf [

	^ self new setFromXrQuaternionf: anXrQuaternionf
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

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:56'
}
Quaternion >> rotateVector: aVector3 [

	| w r u |
	w := self a.
	r := self b @ self c @ self d.
	u := (r cross: aVector3) + (aVector3 * w).
	^ aVector3 + ((r cross: u) * 2)
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'MCPServer (leo) 10/22/2026 18:15'
}
Quaternion >> setFromXrQuaternionf: anXrQuaternionf [

	"copy components as-is; a:b:c:d: would normalize and flip the sign"
	self
		a: anXrQuaternionf w;
		b: anXrQuaternionf x;
		c: anXrQuaternionf y;
		d: anXrQuaternionf z
]
