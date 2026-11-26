"
The point of an object closest to a ray and its distance to that ray.
"
Class {
	#name : #SRRayProximity,
	#superclass : #Object,
	#instVars : [
		'point',
		'distance',
		'object'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity class >> object: anSRObject point: aVector3 distance: aNumber [

	^ self new
		object: anSRObject;
		point: aVector3;
		distance: aNumber;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> distance [

	^ distance
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> distance: aNumber [

	distance := aNumber
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> object [

	^ object
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> object: anSRObject [

	object := anSRObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> point [

	^ point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:45'
}
SRRayProximity >> point: aVector3 [

	point := aVector3
]
