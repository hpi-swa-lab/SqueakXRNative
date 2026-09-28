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
		'haloSpecies',
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
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:04'
}
SRHaloState >> activeHalo: anObject [
	
	activeHalo ifNotNil: [ self removeChild: activeHalo ]. 
	activeHalo := anObject.
	activeHalo ifNotNil: [ self addChild: activeHalo ].
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
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:26'
}
SRHaloState >> haloSpecies [
	^ haloSpecies
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:26'
}
SRHaloState >> haloSpecies: anObject [
	haloSpecies := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:26'
}
SRHaloState >> initialize [ 

	super initialize.
	outlines := Dictionary new.
	highlights := Dictionary new.
	haloSpecies := SRMenuHalo.
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
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:03'
}
SRHaloState >> openHaloOn: anObject with: aHand [

	| halo |
	halo := anObject ifNotNil: [ self haloSpecies new
		hand: aHand;
		target: anObject
	].
	self activeHalo: halo.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:16'
}
SRHaloState >> renderOn: anSRRenderer [

	self activeHalo ifNotNil: [:halo |
		halo target ifNotNil: [:target |
			self addOutlineFor: target colored: Color green
		]
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
