"
Tests for SRLight.
"
Class {
	#name : #SRLightTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Graphics',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:05'
}
SRLightTest >> testDirectionFollowsGlobalRotation [

	| parent light |
	parent := SRObject new.
	light := SRDirectionalLight new.
	parent addChild: light.
	parent localRotation: (Quaternion angle: 90 axis: 0 @ 1 @ 0).
	
	self assert: ((light direction - (-1 @ 0 @ 0)) length) < 1.0e-6.
]
