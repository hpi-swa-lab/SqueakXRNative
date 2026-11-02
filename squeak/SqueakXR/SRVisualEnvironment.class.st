"
General rendering settings of a world.
"
Class {
	#name : #SRVisualEnvironment,
	#superclass : #Object,
	#instVars : [
		'ambientColor',
		'clearColor'
	],
	#classVars : [
		'DefaultAmbientColor',
		'DefaultClearColor'
	],
	#category : #'SqueakXR-Graphics',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment class >> defaultAmbientColor [
	<preference: 'Ambient color'
		category: 'SqueakXR'
		description: 'Ambient light color of visual environments that do not set their own'
		type: #Color>

	^ DefaultAmbientColor ifNil: [Color gray: 0.2]
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment class >> defaultAmbientColor: aColor [

	DefaultAmbientColor := aColor.
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment class >> defaultClearColor [
	<preference: 'Clear color'
		category: 'SqueakXR'
		description: 'Clear color of visual environments that do not set their own'
		type: #Color>

	^ DefaultClearColor ifNil: [Color r: 0.753 g: 0.973 b: 0.977]
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment class >> defaultClearColor: aColor [

	DefaultClearColor := aColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment >> ambientColor [

	^ ambientColor ifNil: [self class defaultAmbientColor]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRVisualEnvironment >> ambientColor: aColor [

	ambientColor := aColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:17'
}
SRVisualEnvironment >> clearColor [

	^ clearColor ifNil: [self class defaultClearColor]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRVisualEnvironment >> clearColor: aColor [

	clearColor := aColor.
]
