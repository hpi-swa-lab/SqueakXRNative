"
Picks halo targets near my forward ray using IntenSelect+ scoring. Attach me to a hand.
"
Class {
	#name : #SRIntenSelect,
	#superclass : #SRObject,
	#instVars : [
		'scores',
		'target'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect class >> coneAngle [

	^ 15 degreesToRadians
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
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect class >> minimumScore [

	^ 0.01
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
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> candidates [

	^ self world
		ifNil: [#()]
		ifNotNil: [:world | world allDescendantsSelect: [:object |
			object isCursorTarget and: [object findHaloTarget notNil]]]
]

{
	#category : #scoring,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> closestProximitiesAlong: aRay [

	| closest |
	closest := IdentityDictionary new.
	(aRay proximitiesToObjects: self candidates) do: [:proximity | | owner |
		owner := proximity object findHaloTarget.
		(closest at: owner ifAbsent: [nil])
			ifNil: [closest at: owner put: proximity]
			ifNotNil: [:other |
				(self contributionOf: proximity along: aRay) > (self contributionOf: other along: aRay)
					ifTrue: [closest at: owner put: proximity]]].
	^ closest
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
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> initialize [

	super initialize.
	scores := IdentityDictionary new.
	self ignoreCollision: true.
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
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> showTargetAt: aProximity [

	target ifNil: [^ self].
	target addHighlight: self class highlightColor.
	aProximity ifNil: [^ self].
	self gizmoPainter ifNotNil: [:painter |
		painter gizmoLine: self globalTranslation to: aProximity point color: self class highlightColor].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> step: deltaTime [

	| ray proximities |
	ray := self rayForward.
	proximities := self closestProximitiesAlong: ray.
	self
		updateScores: (proximities collect: [:proximity | self contributionOf: proximity along: ray])
		over: deltaTime.
	self showTargetAt: (proximities at: target ifAbsent: [nil]).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelect >> target [

	^ target
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
