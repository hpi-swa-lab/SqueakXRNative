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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRTool >> handleRaycast: aHandRayIntersectionResult [

	^ false
]

{
	#category : #comparing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRTool >> isSameToolAs: anSRTool [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRTool >> newPreviewObject [

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
