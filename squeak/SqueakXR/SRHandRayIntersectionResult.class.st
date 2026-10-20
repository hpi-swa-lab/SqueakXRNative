"
A ray hit reported to the object that was hit, carrying the hand that cast it.

The hand is here because an application may hold a different tool in each hand, so #onRaycast: has to be able to tell them apart.
"
Class {
	#name : #SRHandRayIntersectionResult,
	#superclass : #SRRayIntersectionResult,
	#instVars : [
		'actionState',
		'hand'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/8/2026 15:48'
}
SRHandRayIntersectionResult >> actionState [

	^ actionState
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/8/2026 15:49'
}
SRHandRayIntersectionResult >> actionState: state [

	actionState := state
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:42'
}
SRHandRayIntersectionResult >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:42'
}
SRHandRayIntersectionResult >> hand: aHand [
	hand := aHand.
]
