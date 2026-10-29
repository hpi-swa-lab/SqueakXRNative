"
A SRHaloConfigMenu is a visual menu floating in the world to configure the halo.

Instance Variables

"
Class {
	#name : #SRHaloConfigMenu,
	#superclass : #SRObject,
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/29/2026 13:41'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 14:21'
}
SRHaloConfigMenu class >> buttonSpacing [
	^1cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 14:21'
}
SRHaloConfigMenu class >> rowSpacing [ 

	^14cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 14:21'
}
SRHaloConfigMenu class >> rowY: row [

	^(row negated + 1) * self rowSpacing
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:28'
}
SRHaloConfigMenu >> addAnchorRow [
	
	| left |
	left := 0.
	SRHalo allSubclassesDo: [:species | | button width |
		button := SRHaloButton new
			text: species class name;
			clickAction: [SRWorld haloSpecies: species].
		width := button width.
		button position: (left + (width / 2))@0@0.
		self addChild: button.
		left := left + width + self class buttonSpacing.
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:28'
}
SRHaloConfigMenu >> addSpeciesRow [
	
	| left y anchors |
	left := 0.
	y := self class rowY: 2.
	anchors := [SRHaloAnchor all].
	SRHaloAnchor all do: [:anchor | | button width |
		button := SRHaloButton new
			text: anchor asString;
			clickAction: [SRWorld haloAnchor: anchor].
		width := button width.
		button position: (left + (width / 2))@y@0.
		self addChild: button.
		left := left + width + self class buttonSpacing.
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 14:20'
}
SRHaloConfigMenu >> initialize [ 

	super initialize.
	self 
		addSpeciesRow;
		addAnchorRow.
]
