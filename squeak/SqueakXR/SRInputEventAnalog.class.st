Class {
	#name : #SRInputEventAnalog,
	#superclass : #SRInputEvent,
	#instVars : [
		'axis',
		'value'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:59'
}
SRInputEventAnalog >> axis [
	^ axis
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:59'
}
SRInputEventAnalog >> axis: anObject [
	axis := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:59'
}
SRInputEventAnalog >> value [
	^ value
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:59'
}
SRInputEventAnalog >> value: anObject [
	value := anObject
]
