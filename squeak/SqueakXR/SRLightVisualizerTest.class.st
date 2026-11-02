"
Tests for SRLightVisualizer.
"
Class {
	#name : #SRLightVisualizerTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'previousWorld'
	],
	#category : #'SqueakXR-Tests-Graphics',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizerTest >> paintedKinds [

	| visualizer |
	visualizer := SRLightVisualizer new.
	world addChild: visualizer.
	SRFrame world: world deltaTime: 0.
	visualizer step: 0.
	^ (world gizmoPainter commands collect: [:command | command first]) asBag
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizerTest >> setUp [

	super setUp.
	previousWorld := SRWorld current.
	world := SRWorld new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizerTest >> tearDown [

	SRWorld current: previousWorld.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizerTest >> testPaintsEveryLightOfTheWorld [

	world
		addChild: (SRPointLight new range: 2 m; yourself);
		addChild: SRDirectionalLight new.
	
	self
		assert: #(wireSphere wireSphere wireSphere wireCube) asBag
		equals: self paintedKinds.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizerTest >> testPaintsNothingWithoutLights [

	self assert: self paintedKinds isEmpty.
]
