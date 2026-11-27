"
Picks the object near my forward ray using IntenSelect+ scoring.
"
Class {
	#name : #SRIntenSelect,
	#superclass : #SRObject,
	#instVars : [
		'scores',
		'target',
		'targetProximity'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:42'
}
SRIntenSelect class >> coneAngle [

	^ 5 degreesToRadians
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect class >> coneColor [

	^ Color gray
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect class >> coneLength [

	^ 10 m
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect class >> coneRings [

	^ 10
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect class >> distanceCompensation [

	^ 0.8
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect class >> highlightColor [

	^ Color orange
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese 11/27/2026 16:50'
}
SRIntenSelect class >> minimumScore [

	^ 0.05
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect class >> responsiveness [

	^ 10
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:38'
}
SRIntenSelect >> candidates [

	^ self world
		ifNil: [#()]
		ifNotNil: [:world | world allDescendantsSelect: [:object | object isCursorTarget]]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect >> coneRadiusAt: aDepth [

	^ self class coneAngle tan * (aDepth raisedTo: self class distanceCompensation)
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> contributionOf: aProximity along: aRay [

	| depth angle |
	depth := aProximity point - aRay origin dot: aRay forward.
	depth <= 0 ifTrue: [^ 0].
	angle := (aProximity distance / (depth raisedTo: self class distanceCompensation)) arcTan.
	^ 1 - (angle / self class coneAngle) max: 0
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect >> forgetObjectsOutsideWorld [

	scores keys do: [:object |
		(object world notNil and: [object world == self world]) ifFalse: [scores removeKey: object]].
	(scores includesKey: target) ifFalse: [target := nil].
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> initialize [

	super initialize.
	scores := IdentityDictionary new.
	self ignoreCollision: true.
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:38'
}
SRIntenSelect >> proximitiesAlong: aRay [

	| proximities |
	proximities := IdentityDictionary new.
	(aRay proximitiesToObjects: self candidates) do: [:proximity |
		proximities at: proximity object put: proximity].
	^ proximities
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> scoreOf: anSRObject [

	^ scores at: anSRObject ifAbsent: [0]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:35'
}
SRIntenSelect >> showCone [

	| painter origin forward |
	painter := self gizmoPainter ifNil: [^ self].
	origin := self globalTranslation.
	forward := self forward.
	painter gizmoLine: origin to: origin + (forward * self class coneLength) color: self class coneColor.
	1 to: self class coneRings do: [:index | | depth |
		depth := self class coneLength * index / self class coneRings.
		painter
			gizmoWireCircleAt: origin + (forward * depth)
			axis: forward
			radius: (self coneRadiusAt: depth)
			color: self class coneColor].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:29'
}
SRIntenSelect >> showTarget [

	target ifNil: [^ self].
	target addHighlight: self class highlightColor.
	targetProximity ifNil: [^ self].
	self gizmoPainter ifNotNil: [:painter |
		painter gizmoLine: self globalTranslation to: targetProximity point color: self class highlightColor].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:38'
}
SRIntenSelect >> step: deltaTime [

	| ray proximities |
	ray := self rayForward.
	proximities := self proximitiesAlong: ray.
	self
		updateScores: (proximities collect: [:proximity | self contributionOf: proximity along: ray])
		over: deltaTime.
	self forgetObjectsOutsideWorld.
	targetProximity := proximities at: target ifAbsent: [nil].
	self
		showCone;
		showTarget.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> target [

	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:29'
}
SRIntenSelect >> targetProximity [

	^ targetProximity
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> updateScores: contributions over: deltaTime [

	| blend |
	blend := 1 - (self class responsiveness negated * deltaTime) exp.
	(scores keys asSet addAll: contributions keys; yourself) do: [:object | | score |
		score := self scoreOf: object.
		score := score + (((contributions at: object ifAbsent: [0]) - score) * blend).
		score > self class minimumScore
			ifTrue: [scores at: object put: score]
			ifFalse: [scores removeKey: object ifAbsent: []]].
	target := scores keys detectMax: [:object | scores at: object].
]
