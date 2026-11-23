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
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRXRControllerInputStrategy >> actionsUpdated: someActionStates [

	avatar hands do: [:each | each actionsUpdated: someActionStates].
]

{
	#category : #input,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRXRControllerInputStrategy >> handJointsUpdated: someHandJoints [

	avatar enableHandTracking do: [:each | each jointsUpdated: someHandJoints].
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
