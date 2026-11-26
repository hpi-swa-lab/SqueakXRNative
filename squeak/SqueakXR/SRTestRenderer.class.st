"
Records setup and shutdown instead of drawing.
"
Class {
	#name : #SRTestRenderer,
	#superclass : #SRRenderer,
	#instVars : [
		'isXR',
		'windowPriority',
		'events'
	],
	#category : #'SqueakXR-Tests-Helpers',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer class >> flat [

	^ self new setXR: false windowPriority: 2
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer class >> xr [

	^ self new setXR: true windowPriority: 1
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> canStartWhileRunning [

	^ isXR not
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> events [

	^ events
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> isXR [

	^ isXR
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:31'
}
SRTestRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	events add: #cube.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:31'
}
SRTestRenderer >> renderPlainCubeTransformed: aMatrix4x4 withColor: aColor [

	events add: #cube.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> setXR: aBoolean windowPriority: aNumber [

	isXR := aBoolean.
	windowPriority := aNumber.
	events := OrderedCollection new.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> setup [

	events add: #setup.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> shutdown [

	events add: #shutdown.
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRTestRenderer >> windowPriority [

	^ windowPriority
]
