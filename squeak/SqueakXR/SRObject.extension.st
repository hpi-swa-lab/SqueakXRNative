Extension { #name : #SRObject }

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:37'
}
SRObject >> addHalo [
	
	^ self createHalo
		popUpFor: self;
		yourself
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:41'
}
SRObject >> findHaloTarget [

	"Find a suitable halo target along the path to the top node.
	Suitable nodes are ones that want a Halo and are not part of a subtree which disallows them."
	| here target |
	target := nil.
	here := self.
	[ here isNil ] whileFalse: [
		"No halo allowed in this subtree!"
		here allowsHalo ifFalse: [ ^ nil ].
		here hasHalo ifTrue: [ ^ target ].
		here wantsHalo ifTrue: [ target := here ].
		here := here parent.
	].
	^ target
	
	
]
