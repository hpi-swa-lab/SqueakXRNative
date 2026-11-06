Extension { #name : #XrQuaternionf }

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'MCPServer (leo) 11/6/2026 16:34'
}
XrQuaternionf >> asQuaternion [

	^ Quaternion fromXrQuaternionf: self
]
