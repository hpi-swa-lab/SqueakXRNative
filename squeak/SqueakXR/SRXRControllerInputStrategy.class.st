"
Drives its avatar from the XR headset and controllers.
"
Class {
	#name : #SRXRControllerInputStrategy,
	#superclass : #SRInputStrategy,
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #input,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 15:47'
}
SRXRControllerInputStrategy >> actionsUpdated: someActionStates [

	avatar activeHands do: [:each | each actionsUpdated: someActionStates].
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 15:47'
}
SRXRControllerInputStrategy >> detach [

	avatar ifNotNil: [:anAvatar | anAvatar useControllerHands].
	super detach.
]

{
	#category : #input,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 18:19'
}
SRXRControllerInputStrategy >> handJointsUpdated: someHandJoints [

	avatar trackedHands ifNil: [^ self].
	someHandJoints isActive = avatar usesTrackedHands ifFalse: [
		someHandJoints isActive
			ifTrue: [avatar useTrackedHands]
			ifFalse: [avatar useControllerHands]].
	avatar usesTrackedHands ifTrue: [
		avatar trackedHands do: [:each | each jointsUpdated: someHandJoints]].
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:07'
}
SRXRControllerInputStrategy >> isControllerInput [

	^ true
]

{
	#category : #updating,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRXRControllerInputStrategy >> update: anAspect with: anObject [

	anAspect = #actionsUpdated ifTrue: [^ self actionsUpdated: anObject].
	anAspect = #handJointsUpdated ifTrue: [^ self handJointsUpdated: anObject].
	anAspect = #cameraTransformUpdated ifTrue: [^ avatar camera cameraTransformUpdated: anObject]
]
