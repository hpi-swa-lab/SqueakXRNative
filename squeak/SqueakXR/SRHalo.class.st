"
A SRHalo is xxxxxxxxx.

Instance Variables
	center:		<Object>
	hand:		<Object>
	target:		<Object>

center
	- position this halo is invoked at

hand
	- hand invoking this halo

target
	- target object

"
Class {
	#name : #SRHalo,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'target',
		'center'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:38'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:38'
}
SRHalo >> center [
	^ center
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:38'
}
SRHalo >> center: anObject [
	center := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:27'
}
SRHalo >> hand [
	"The hand this halo was triggered by"
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:27'
}
SRHalo >> hand: anObject [
	hand := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 09:51'
}
SRHalo >> open [

	"Trigger the halo to open. 
	In this moment, hand and target should have been set and the halo must be part of the world tree."
	^self subclassResponsibility 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:55'
}
SRHalo >> target [
	^target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:55'
}
SRHalo >> target: anObject [
	target := anObject
]
