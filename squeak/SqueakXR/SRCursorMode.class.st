Class {
	#name : #SRCursorMode,
	#superclass : #Object,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/20/2026 13:50'
}
SRCursorMode class >> ignore [
	"I don't want cursor events and will pass them along to my parent."
	^ #ignore
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/20/2026 13:58'
}
SRCursorMode class >> pass [
	"I want cursor events but may not handle them.
	Any unhandled events will be propagated to my parent."
	^ #pass
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/20/2026 13:52'
}
SRCursorMode class >> stop [
	"I want inputs and will handle them myself.
	Events will not propagate up to my parent."
	^ #stop
]
