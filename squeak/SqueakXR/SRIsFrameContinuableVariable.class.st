"
True while an SRFrame hands over an error it can skip. Other errors in the world process leave the frame in an unknown state.
"
Class {
	#name : #SRIsFrameContinuableVariable,
	#superclass : #DynamicVariable,
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
}
SRIsFrameContinuableVariable >> default [

	^ false
]
