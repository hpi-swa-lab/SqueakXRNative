"
Shows gizmos for all lights of its world.
"
Class {
	#name : #SRLightVisualizer,
	#superclass : #SRObject,
	#category : #'SqueakXR-Graphics-Lighting',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:17'
}
SRLightVisualizer >> step: delta [

	self world lightsBuffer do: [:light | light gizmoVisualize].
]
