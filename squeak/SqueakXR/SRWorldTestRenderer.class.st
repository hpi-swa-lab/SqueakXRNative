"
Records which floor parts a world renders.
"
Class {
	#name : #SRWorldTestRenderer,
	#superclass : #Object,
	#instVars : [
		'rendered'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTestRenderer >> initialize [

	super initialize.
	rendered := OrderedCollection new
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTestRenderer >> renderGridSlices: aNumber spacing: aSpacing [

	rendered add: #grid
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTestRenderer >> renderHolodeckGridSize: aNumber [

	rendered add: #grid
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTestRenderer >> renderSlabAt: aVector3 size: aNumber thickness: aThickness [

	rendered add: #slab
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTestRenderer >> rendered [

	^ rendered
]
