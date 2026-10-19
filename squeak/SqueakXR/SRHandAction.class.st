"
A SRHandAction is an action performed by an SRHand.

Instance Variables
	hand:		<Object>

hand
	- xxxxx

"
Class {
	#name : #SRHandAction,
	#superclass : #Object,
	#instVars : [
		'hand'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:27'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:27'
}
SRHandAction >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:30'
}
SRHandAction >> hand: aSRHand [
	
	hand := aSRHand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:19'
}
SRHandAction >> perform: inputState [

	"Perform this action using the provided input state or do nothing.
	Return false if following actions should not be processed."
	
	"By default, do nothing and allow others to run."
	^ true
]
