"
Shines along its forward direction. Range is measured from its position along that direction.
"
Class {
	#name : #SRDirectionalLight,
	#superclass : #SRLight,
	#category : #'SqueakXR-Graphics-Lighting',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRDirectionalLight class >> gizmoLength [

	^ 40 cm
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:01'
}
SRDirectionalLight class >> typeId [

	^ 1
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRDirectionalLight >> gizmoCuboidTransform [

	| length thickness |
	length := self class gizmoLength.
	thickness := self class gizmoSize / 4.
	^ (Matrix4x4 withOffset: self globalTranslation + (self direction * length / 2))
		* self globalRotation asMatrix4x4
		* (Matrix4x4 withScale: thickness @ thickness @ length)
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRDirectionalLight >> gizmoVisualize [

	self gizmoVisualizeCenter.
	self gizmoPainter gizmoWireCube: self gizmoCuboidTransform color: color.
	self hasRange ifTrue: [
		self gizmoPainter
			gizmoLineFrom: self globalTranslation
			to: self globalTranslation + (self direction * range)
			color: color].
]
