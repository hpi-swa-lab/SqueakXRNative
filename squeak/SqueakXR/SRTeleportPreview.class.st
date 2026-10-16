"
The arc and landing highlight shown while a teleport is being aimed.

The beads are made once and hidden rather than created and removed per frame: this is rebuilt every frame while the stick is held, and a scene graph edit per frame costs more than the cubes do.

Not a child of the avatar. It marks a place in the world, and a child of the rig would be carried along by the very teleport it is previewing.
"
Class {
	#name : #SRTeleportPreview,
	#superclass : #SRObject,
	#instVars : [
		'beads',
		'marker'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRTeleportPreview class >> beadCount [
	"One per arc segment. SRBallisticArc answers at most maxSteps + 1 points."

	^ 31
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:41'
}
SRTeleportPreview class >> invalidColor [
	^ Color r: 0.9 g: 0.25 b: 0.2
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRTeleportPreview class >> validColor [
	^ Color r: 0.3 g: 0.85 b: 1.0
]

{
	#category : #displaying,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRTeleportPreview >> hide [
	self visible: false
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRTeleportPreview >> initialize [
	super initialize.
	beads := (1 to: self class beadCount) collect: [:i |
		SRFastCube new
			scale: 4 cm asVector3;
			visible: false;
			yourself].
	marker := SRFastCube new
		scale: (60 cm) @ (2 cm) @ (60 cm);
		visible: false;
		yourself.
	self addChildren: (beads copyWith: marker).
	self visible: false.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:41'
}
SRTeleportPreview >> landingPoint [
	"Where a release would put the player, or nil when the arc reached nothing."

	^ marker visible ifTrue: [marker position - (0 @ 1 cm @ 0)]
]

{
	#category : #displaying,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRTeleportPreview >> showArc: anArc [
	"A curve that reached nothing is drawn red and the marker is left off, so
	releasing on it visibly does nothing rather than silently doing nothing."

	| colour landed |
	landed := anArc hit notNil.
	colour := landed ifTrue: [self class validColor] ifFalse: [self class invalidColor].
	self visible: true.
	beads doWithIndex: [:bead :i |
		i <= anArc points size
			ifTrue: [bead
				position: (anArc points at: i);
				color: colour;
				visible: true]
			ifFalse: [bead visible: false]].
	marker visible: landed.
	landed ifTrue: [marker
		position: anArc hit point + (0 @ 1 cm @ 0);
		color: colour].
]
