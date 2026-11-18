"
A Godot-style tween transition curve. Subclasses define the ease-in shape on [0, 1].
"
Class {
	#name : #SRTransition,
	#superclass : #Object,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> all [

	^ self subclasses collect: [:each | each new]
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> back [

	^ SRBackTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> bounce [

	^ SRBounceTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> circ [

	^ SRCircTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> cubic [

	^ SRCubicTransition new
]

{
	#category : #eases,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> eases [

	^ #(#in #out #inOut #outIn)
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> elastic [

	^ SRElasticTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> expo [

	^ SRExpoTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> linear [

	^ SRLinearTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> quad [

	^ SRQuadTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> quart [

	^ SRQuartTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> quint [

	^ SRQuintTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> sine [

	^ SRSineTransition new
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition class >> spring [

	^ SRSpringTransition new
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition >> in: aProgress [

	^ self subclassResponsibility
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition >> inOut: aProgress [

	^ aProgress < 0.5
		ifTrue: [(self in: aProgress * 2) / 2]
		ifFalse: [(self out: aProgress * 2 - 1) / 2 + 0.5]
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition >> out: aProgress [

	^ 1 - (self in: 1 - aProgress)
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition >> outIn: aProgress [

	^ aProgress < 0.5
		ifTrue: [(self out: aProgress * 2) / 2]
		ifFalse: [(self in: aProgress * 2 - 1) / 2 + 0.5]
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTransition >> value: aProgress ease: anEaseSymbol [

	^ anEaseSymbol caseOf: {
		[#in] -> [self in: aProgress].
		[#out] -> [self out: aProgress].
		[#inOut] -> [self inOut: aProgress].
		[#outIn] -> [self outIn: aProgress]}
]
