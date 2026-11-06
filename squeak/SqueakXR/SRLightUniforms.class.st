"
Uploads lighting state to the uniforms of one shader.
"
Class {
	#name : #SRLightUniforms,
	#superclass : #Object,
	#instVars : [
		'shader',
		'ambientColorLoc',
		'viewPositionLoc',
		'lightCountLoc',
		'lightLocs'
	],
	#category : #'SqueakXR-Graphics-Lighting',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLightUniforms class >> forShader: aSRShader [

	^ self new setShader: aSRShader
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms class >> isUsedBy: aSRShader [

	^ (aSRShader locationOf: self lightCountName) >= 0
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms class >> lightCountName [

	^ 'lightCount'
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLightUniforms class >> lightMembers [

	^ #(type position direction color range)
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms >> lightLocationsAt: anIndex [

	^ self class lightMembers
		collect: [:member | member -> (shader locationOf: 'lights[', anIndex printString, '].', member)]
		as: Dictionary
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms >> resolveLocations [

	ambientColorLoc := shader locationOf: 'ambientColor'.
	viewPositionLoc := shader locationOf: 'viewPosition'.
	lightCountLoc := shader locationOf: self class lightCountName.
	lightLocs := (0 to: SRLight maxCount - 1) collect: [:index | self lightLocationsAt: index].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms >> setShader: aSRShader [

	shader := aSRShader.
	self resolveLocations.
]

{
	#category : #uploading,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:08'
}
SRLightUniforms >> uploadLight: aLight to: aDictionary [

	shader
		setInt: aLight class typeId at: (aDictionary at: #type);
		setVector: aLight globalTranslation at: (aDictionary at: #position);
		setVector: aLight direction at: (aDictionary at: #direction);
		setColor: aLight color intensity: aLight intensity at: (aDictionary at: #color);
		setFloat: aLight range at: (aDictionary at: #range).
]

{
	#category : #uploading,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRLightUniforms >> uploadLightArray: aCollection [

	| count |
	count := aCollection size min: SRLight maxCount.
	shader setInt: count at: lightCountLoc.
	1 to: count do: [:index |
		self uploadLight: (aCollection at: index) to: (lightLocs at: index)].
]

{
	#category : #uploading,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:08'
}
SRLightUniforms >> uploadLights: aCollection ambientColor: aColor viewPosition: aVector3 [

	shader
		setColor: aColor intensity: 1 at: ambientColorLoc;
		setVector: aVector3 at: viewPositionLoc.
	self uploadLightArray: aCollection.
]
