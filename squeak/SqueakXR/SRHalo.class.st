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
		'center',
		'spec'
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/5/2026 17:36'
}
SRHalo >> close [

	"Called by SRHaloState when this halo is closed, but before being removed from the tree."
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:02'
}
SRHalo >> haloSpec [ 

	"Halos don't want a Halo themselves."
	^ nil
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
	#'squeak_changestamp' : 'phkeese 10/5/2026 17:37'
}
SRHalo >> open [

	"Called by SRHaloState just after adding this halo to the world tree."
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:01'
}
SRHalo >> spec [
	^ spec
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:01'
}
SRHalo >> spec: anObject [
	spec := anObject
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
