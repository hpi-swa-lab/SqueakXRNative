Class {
	#name : #SRGizmoPainter,
	#superclass : #SRObject,
	#instVars : [
		'commands'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 14:33'
}
SRGizmoPainter >> drawSphere: command renderer: aSRRenderer [

	| transform |
	transform := (Matrix4x4 withOffset: command second) * (Matrix4x4 withScale: command third asVector3).
	aSRRenderer renderSphereTransformed: transform withColor: command fourth.
	"aSRRenderer
		drawSphereWiresCenterPos: command second
		radius: command third
		rings: 16
		slices: 16
		color: command fourth"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 14:24'
}
SRGizmoPainter >> gizmoSphere: globalPosition size: size color: color [

	commands add: {#sphere. globalPosition. size. color}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 18:20'
}
SRGizmoPainter >> initialize [

	super initialize.
	
	commands := OrderedCollection new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 13:58'
}
SRGizmoPainter >> renderOn: aSRRenderer [

	commands do: [:command |
		command first caseOf: {
			[#sphere] -> [self drawSphere: command renderer: aSRRenderer]}].
	commands removeAll.
]
