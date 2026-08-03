Class {
	#name : #SRPasteUpMorph,
	#superclass : #PasteUpMorph,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:57'
}
SRPasteUpMorph >> addedMorph: aMorph [

	| camera |
	(SRIsAddingMorphsToWorldVariable value
		and: [aMorph shouldBeInMorphPanel]
		and: [aMorph isInMorphPanel not]) ifTrue: [ | transform |
		"place the panel in front of the user"
		camera := self currentXRWorld camera.
		transform := Matrix4x4
			objectLookAt: camera globalTranslation
			from: camera globalTranslation + (camera forward * 1.25)
			up: Vector3 up.
		self currentXRWorld addChild: (
			SRMorphPanel new
				morph: aMorph;
				globalTransform: transform)].
]

{
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:23'
}
SRPasteUpMorph >> allowsMorphGrabbing [
	"No. Grabbing removes the morph from this world, which fires removedMorph:
	and tears down the SRMorphPanel rendering it. Dragging in 3D has its own
	mechanism. Consulted by #morphToGrab:."
	^false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:34'
}
SRPasteUpMorph >> beWorldForProject: aProject [

	self privateOwner: nil.
	worldState := SRWorldState new.
	self addHand: HandMorph new.
	self setProperty: #automaticPhraseExpansion toValue: true.
	self setProperty: #optimumExtentFromAuthor toValue: Display extent.
	self startSteppingSubmorphsOf: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:31'
}
SRPasteUpMorph >> invalidRect: damageRect from: aMorph [

	self isWorldMorph
		ifTrue: [worldState recordDamagedRect: damageRect from: aMorph].
	^super invalidRect: damageRect from: aMorph
]

{
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:45'
}
SRPasteUpMorph >> morphToGrab: event [
	"Answer nil, so nothing is picked up out of this world.

	PasteUpMorph>>mouseDown: is the only sender, and it is exactly where a plain
	morph -- one that handles no mouse events of its own -- gets grabbed: the
	mouseDown finds no handler on the way down, bubbles all the way up, the world
	becomes the handler, and #mouseDown: hands whatever #morphToGrab: answers to
	HandMorph>>grabMorph:. Stopping here is upstream of #aboutToBeGrabbedBy:,
	which is a notification, not a veto point.

	Grabbing would take the morph out of this world, firing #removedMorph: and
	tearing down the SRMorphPanel rendering it. Dragging in 3D has its own
	mechanism.

	This covers only the world-initiated grab. Morphs that grab themselves --
	SystemWindow>>startDragFromLabel:, list drag sources, halos -- call
	HandMorph>>grabMorph: directly and never ask me. Those are stopped by
	#isSticky instead, see Morph>>setInMorphPanel:."

	^ self allowsMorphGrabbing
		ifTrue: [super morphToGrab: event]
		ifFalse: [nil]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:45'
}
SRPasteUpMorph >> removedMorph: aMorph [

	aMorph isInMorphPanel ifTrue: [
		self currentXRWorld allDescendantsSelect: [:obj |
				obj isMorphPanel and: [obj morph = aMorph]]
			thenDo: [:panel |
				panel removeMorph.
				self currentXRWorld removeChild: panel]]
]
