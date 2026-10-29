"
Stores Halo state across frames like what to highlight, which objects are currently targetet, etc.

Instance Variables

"
Class {
	#name : #SRHaloState,
	#superclass : #SRObject,
	#instVars : [
		'outlines',
		'highlights',
		'activeHalo'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/22/2026 15:09'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:46'
}
SRHaloState >> activeHalo [
	^ activeHalo
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:16'
}
SRHaloState >> activeHalo: aHalo [
	
	activeHalo := aHalo.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:08'
}
SRHaloState >> addOutlineFor: anSRObject colored: aColor [
	outlines at: anSRObject 
		ifPresent: [:list | list add: aColor ]
		ifAbsentPut: [ OrderedCollection new add: aColor; yourself ]
	
]

{
	#category : #'halo lifecycle',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:38'
}
SRHaloState >> closeHalo [ 

	"Close any currently active halo, if there is one."
	self activeHalo ifNotNil: [:halo | 
		Transcript showln: 'Closing Halo ', halo.
		halo close ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 13:55'
}
SRHaloState >> initialize [ 

	super initialize.
	outlines := Dictionary new.
	highlights := Dictionary new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:17'
}
SRHaloState >> mixColors: aCollection [

	^aCollection last
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:37'
}
SRHaloState >> renderOn: anSRRenderer [

	self activeHalo ifNotNil: [:halo |
		halo target addHighlight: Color green.
		self gizmoPainter gizmoLine: halo center to: halo target globalTranslation color: Color green.
	].
	outlines keysAndValuesDo: [:object :colors | | effectiveColor |
		effectiveColor := self mixColors: colors.
		object collisionGeometryDo: [:geom |
			geom drawGizmoOn: self gizmoPainter colored: effectiveColor.
		]
	].
	
	outlines removeAll.
	highlights removeAll.
]
