"
A SRCursor is an abstract input handler for an SRHand. It receives trigger, grip & face button inputs and selects objects in the world.

Instance Variables
hand - SRHand this cursor belongs to
"
Class {
	#name : #SRCursor,
	#superclass : #SRObject,
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 9/14/2026 14:55'
}

{
	#category : #input,
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:12'
}
SRCursor >> onInputsChanged: anInputState [

	"Called when my hand's inputs change"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:12'
}
SRCursor >> parent: anSRObject [

	self parent ifNotNil: [ :parent | parent removeDependent: self ].
	super parent: anSRObject.
	self parent ifNotNil: [ :parent | parent addDependent: self ].
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/14/2026 15:35'
}
SRCursor >> update: anAspect with: anObject [

	anAspect = #inputsChanged ifTrue: [ self onInputsChanged: anObject ].
]
