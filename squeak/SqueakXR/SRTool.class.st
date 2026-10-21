"
What a hand does when the trigger is pulled, held by SRHand.

Not an SRObject: a tool is not in the scene. An application subclasses this and keeps whatever the action needs as state, which is how two hands can hold the same kind of tool set to different things.
"
Class {
	#name : #SRTool,
	#superclass : #Object,
	#category : #'SqueakXR-Tools',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #acting,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:59'
}
SRTool >> handleRaycast: aHandRayIntersectionResult [
	"Answer whether the hit was used up. Declining leaves the object to its own
	#onRaycast:, which is how menus and panels keep working while a tool is held."

	^ false
]

{
	#category : #comparing,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:05'
}
SRTool >> isSameToolAs: anSRTool [
	"Tool sameness as a menu means it. An app hands out fresh instances so that
	two hands can hold one kind of tool set differently, which leaves == unable
	to tell a row whether a hand is holding what it offers."

	^ self class == anSRTool class
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:59'
}
SRTool >> label [
	^ self subclassResponsibility
]

{
	#category : #preview,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:56'
}
SRTool >> newPreviewObject [
	"Hangs off the hand, so it must not be pickable: an SRCube has no collision
	geometry, which keeps it out of every ray cast and out of the body sweep.
	Answer nil for a tool that should show nothing."

	^ SRCube new
		color: self previewColor;
		scale: Vector3 one * 4 cm;
		translation: 0 @ 4 cm @ 0;
		yourself
]

{
	#category : #preview,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:56'
}
SRTool >> previewColor [
	^ Color gray
]
