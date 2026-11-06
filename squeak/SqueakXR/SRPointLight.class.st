"
Shines in all directions from its position.
"
Class {
	#name : #SRPointLight,
	#superclass : #SRLight,
	#category : #'SqueakXR-Graphics-Lighting',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRPointLight class >> typeId [

	^ 0
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRPointLight >> gizmoVisualize [

	self gizmoVisualizeCenter.
	self hasRange ifTrue: [
		self gizmoPainter
			gizmoWireSphere: self globalTranslation
			radius: range
			color: color].
]
