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

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 12:52'
}
Quaternion >> rotateVector: aVector3 [
	"Rotate a Vector3 by this quaternion using the efficient formula:
	v' = v + 2 * r cross (r cross v + w * v)
	where q = (w, r) with w=a and r=(b,c,d)
	This avoids intermediate quaternion creation and normalization issues."
	| w r u |
	
	w := self a.
	r := Vector3 x: self b y: self c z: self d.
	
	"Calculate r cross v + w * v"
	u := (r cross: aVector3) + (aVector3 * w).
	
	"Calculate v + 2 * (r cross u)"
	^ aVector3 + ((r cross: u) * 2)
]
