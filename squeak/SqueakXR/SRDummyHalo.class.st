"
A SRDummyHalo is a standin for a real halo to aid in debugging.

Instance Variables

"
Class {
	#name : #SRDummyHalo,
	#superclass : #SRHalo,
	#instVars : [
		'text'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:05'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:20'
}
SRDummyHalo >> initialize [ 

	super initialize.
	self addChild: (SRCube new
		scale: 10cm asVector3).
	text := (SRTextField new
		scale: 10cm asVector3;
		text: '<no target>').
	self addChild: text.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:10'
}
SRDummyHalo >> popUpFor: obj at: point hand: hand [

	Transcript showln: 'Popping up for ', obj, ' at ', point, ' hand: ', hand.
	^ super popUpFor: obj at: point hand: hand 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:21'
}
SRDummyHalo >> target: object [

	super target: object.
	object ifNotNil: [
		text text: '', object
	]
]
