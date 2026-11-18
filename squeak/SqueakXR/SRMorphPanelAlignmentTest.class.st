"
Tests that released SRMorphPanels turn to face the camera.
"
Class {
	#name : #SRMorphPanelAlignmentTest,
	#superclass : #TestCase,
	#instVars : [
		'panel',
		'camera'
	],
	#category : #'SqueakXR-Tests-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:39'
}
SRMorphPanelAlignmentTest >> assertFacesCamera [

	self assert: ((panel forward dot: (camera - panel globalTranslation) normalized) closeTo: 1)
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> assertFacesCameraAxis [

	| toAxis |
	toAxis := camera - panel globalTranslation.
	toAxis y: 0.
	self assert: (panel forward - toAxis normalized) length < 0.001.
	self assert: (panel up - Vector3 up) length < 0.001
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> finishAligning [

	[panel alignmentTween isStepping] whileTrue: [panel alignmentTween step: 0.1]
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> releaseRolledAtHeight: aHeight [

	panel
		globalTranslation: 1m @ (camera y + aHeight) @ -2m;
		globalRotation: (Quaternion angle: 30 axis: Vector3 forward).
	panel alignTowards: camera.
	self finishAligning
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:40'
}
SRMorphPanelAlignmentTest >> setUp [

	super setUp.
	camera := 0 @ 1.6m @ 0.
	panel := SRMorphPanel new
		globalTranslation: 1m @ 3.5m @ -2m;
		globalRotation: (Quaternion angle: 30 axis: Vector3 forward) * (Quaternion angle: 50 axis: Vector3 right);
		yourself
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testAligningIsAnimated [

	panel alignTowards: camera.
	self assert: panel alignmentTween isStepping.
	panel alignmentTween step: 0.1.
	self deny: ((panel forward dot: (camera - panel globalTranslation) normalized) closeTo: 1)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testAligningKeepsThePosition [

	| position |
	position := panel globalTranslation.
	panel alignTowards: camera.
	self finishAligning.
	self assert: (panel globalTranslation - position) length < 0.001
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testAligningTurnsThePanelToFaceTheCamera [

	panel alignTowards: camera.
	self finishAligning.
	self assert: ((panel forward dot: (camera - panel globalTranslation) normalized) closeTo: 1).
	self assert: (panel right y closeTo: 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testAnAlignedPanelDoesNotAnimate [

	panel globalRotation: (panel rotationFacing: camera).
	panel alignTowards: camera.
	self deny: panel alignmentTween isStepping
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> testAtTheLowerBandEdgeFacesTheCameraAxis [

	camera := 0 @ 0 @ 0.
	self releaseRolledAtHeight: -75cm.
	self assertFacesCameraAxis
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> testAtTheUpperBandEdgeFacesTheCameraAxis [

	camera := 0 @ 0 @ 0.
	self releaseRolledAtHeight: 75cm.
	self assertFacesCameraAxis
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testGrabbingAgainStopsAligning [

	panel alignTowards: camera.
	panel alignmentTween step: 0.1.
	panel startGrabbing: nil.
	self deny: panel alignmentTween isStepping
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:41'
}
SRMorphPanelAlignmentTest >> testJustAboveTheBandFacesTheCamera [

	camera := 0 @ 0 @ 0.
	self releaseRolledAtHeight: 76cm.
	self assertFacesCamera
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:41'
}
SRMorphPanelAlignmentTest >> testJustBelowTheBandFacesTheCamera [

	camera := 0 @ 0 @ 0.
	self releaseRolledAtHeight: -76cm.
	self assertFacesCamera
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> testOnTheCameraAxisOnlyStraightensUp [

	camera := 0 @ 0 @ 0.
	panel
		globalTranslation: 0 @ 50cm @ 0;
		globalRotation: (Quaternion angle: 30 axis: Vector3 forward).
	panel alignTowards: camera.
	self finishAligning.
	self assert: (panel up - Vector3 up) length < 0.001.
	self assert: (panel forward - Vector3 forward) length < 0.001
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:36'
}
SRMorphPanelAlignmentTest >> testReleasingOutsideAWorldIsHarmless [

	panel startGrabbing: nil; stopGrabbing: nil.
	self deny: panel alignmentTween isStepping
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:43'
}
SRMorphPanelAlignmentTest >> testUpsideDownInsideTheBandFacesTheCameraAxis [

	camera := 0 @ 0 @ 0.
	panel
		globalTranslation: 1m @ 50cm @ -2m;
		globalRotation: (Quaternion angle: 180 axis: Vector3 forward).
	panel alignTowards: camera.
	self finishAligning.
	self assertFacesCameraAxis
]
