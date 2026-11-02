"
A light source for lit shaders. A negative range means infinite reach.
"
Class {
	#name : #SRLight,
	#superclass : #SRObject,
	#instVars : [
		'color',
		'intensity',
		'range'
	],
	#category : #'SqueakXR-Graphics-Lighting',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLight class >> gizmoSize [

	^ 10 cm
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRLight class >> glslDefines [

	^ String streamContents: [:stream |
		stream
			nextPutAll: '#define MAX_LIGHTS '; print: self maxCount; lf;
			nextPutAll: '#define LIGHT_POINT '; print: SRPointLight typeId; lf;
			nextPutAll: '#define LIGHT_DIRECTIONAL '; print: SRDirectionalLight typeId; lf]
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRLight class >> maxCount [

	^ 10
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRLight class >> typeId [

	^ self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> color [

	^ color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> color: aColor [

	color := aColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRLight >> direction [

	^ (self globalTransform localDirToGlobal: Vector3 forward) normalized
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLight >> gizmoVisualize [

	self gizmoPainter
		gizmoWireCube: (Matrix4x4 withOffset: self globalTranslation) * (Matrix4x4 withScale: self class gizmoSize asVector3)
		color: color.
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLight >> gizmoVisualizeCenter [

	self gizmoPainter
		gizmoWireSphere: self globalTranslation
		radius: self class gizmoSize / 2
		color: color.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLight >> hasRange [

	^ range negative not
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRLight >> initialize [

	super initialize.
	color := Color white.
	intensity := 1.
	range := -1.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> intensity [

	^ intensity
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> intensity: aNumber [

	intensity := aNumber.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:38'
}
SRLight >> isShining [

	^ visible
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> range [

	^ range
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:02'
}
SRLight >> range: aNumber [

	range := aNumber.
]
