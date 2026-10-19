Class {
	#name : #SRIntersectionResult,
	#superclass : #Object,
	#instVars : [
		'point',
		'object',
		'distance'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:54'
}
SRIntersectionResult >> asHandIntersection: actionState [

	^ SRHandIntersectionResult new
		object: self object;
		point: self point;
		distance: self distance;
		actionState: actionState
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> distance [
	^ distance
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> distance: anObject [
	distance := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> object [
	^ object
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> object: anObject [
	object := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> point [
	^ point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:49'
}
SRIntersectionResult >> point: anObject [
	point := anObject
]
