"
Drives one avatar from an input source.
"
Class {
	#name : #SRInputStrategy,
	#superclass : #Object,
	#instVars : [
		'avatar'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #avatar,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRInputStrategy >> attachTo: anAvatar [

	avatar := anAvatar
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:07'
}
SRInputStrategy >> avatar [

	^ avatar
]

{
	#category : #avatar,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRInputStrategy >> detach [

	avatar := nil
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:07'
}
SRInputStrategy >> isControllerInput [

	^ false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRInputStrategy >> world [

	^ avatar ifNotNil: [:anAvatar | anAvatar world]
]
