"
Finds the point of an origin-centered axis-aligned box closest to a ray.
"
Class {
	#name : #SRRayBoxProximity,
	#superclass : #Object,
	#instVars : [
		'ray',
		'halfExtents'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity class >> ray: aRay halfExtents: aVector3 [

	^ self new
		ray: aRay;
		halfExtents: aVector3;
		yourself
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> breakpoints [

	| crossings |
	crossings := (self movingAxes gather: [:axis | self crossingsAlong: axis]) select: [:t | t > 0].
	^ (crossings copyWith: 0) asSortedCollection asArray
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> candidateParameters [

	| bounds |
	bounds := self breakpoints copyWith: Float infinity.
	^ self breakpoints, ((1 to: bounds size - 1) collect: [:index |
		self stationaryParameterFrom: (bounds at: index) to: (bounds at: index + 1)])
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> clamped: aPoint [

	^ halfExtents negated max: (halfExtents min: aPoint)
]

{
	#category : #computing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> closestParameter [

	^ self candidateParameters detectMin: [:t | self squaredDistanceAt: t]
]

{
	#category : #computing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> closestPoint [

	^ self clamped: (ray project: self closestParameter)
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> crossingsAlong: anAxis [

	| origin direction half |
	origin := ray origin perform: anAxis.
	direction := ray forward perform: anAxis.
	half := halfExtents perform: anAxis.
	^ {(half negated - origin) / direction. (half - origin) / direction}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> halfExtents: aVector3 [

	halfExtents := aVector3
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> movingAxes [

	^ #(#x #y #z) reject: [:axis | (ray forward perform: axis) = 0]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> ray: aRay [

	ray := aRay
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> squaredDistanceAt: aParameter [

	| point |
	point := ray project: aParameter.
	^ (point - (self clamped: point)) squaredLength
]

{
	#category : #private,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:29'
}
SRRayBoxProximity >> stationaryParameterFrom: aStart to: anEnd [

	| probe outside numerator denominator |
	probe := ray project: (anEnd = Float infinity
		ifTrue: [aStart + 1]
		ifFalse: [aStart + anEnd / 2]).
	outside := #(#x #y #z) select: [:axis | (probe perform: axis) abs > (halfExtents perform: axis)].
	numerator := outside detectSum: [:axis |
		(ray forward perform: axis) * (((halfExtents perform: axis) * (probe perform: axis) sign) - (ray origin perform: axis))].
	denominator := outside detectSum: [:axis | (ray forward perform: axis) squared].
	denominator = 0 ifTrue: [^ aStart].
	^ ((numerator / denominator) max: aStart) min: anEnd
]
