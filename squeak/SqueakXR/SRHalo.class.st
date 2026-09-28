Class {
	#name : #SRHalo,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'target'
	],
	#category : #'SqueakXR-Halo'
}

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
	#category : #halo,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:34'
}
SRHalo >> openOn: anObject [

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
