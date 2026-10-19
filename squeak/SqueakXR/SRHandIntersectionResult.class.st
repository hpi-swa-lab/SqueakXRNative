Class {
	#name : #SRHandIntersectionResult,
	#superclass : #SRIntersectionResult,
	#instVars : [
		'actionState'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:54'
}
SRHandIntersectionResult >> actionState [
	^ actionState
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:54'
}
SRHandIntersectionResult >> actionState: anObject [
	actionState := anObject
]
