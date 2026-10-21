"
Records what #renderOn: asks of a renderer. Not an SRRenderer: every real one
is a Raylib renderer and would need a GL context.
"
Class {
	#name : #SRRecordingRenderer,
	#superclass : #Object,
	#instVars : [
		'calls'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRRecordingRenderer >> calls [
	^ calls.
]

{
	#category : #recording,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRRecordingRenderer >> doesNotUnderstand: aMessage [
	calls add: aMessage.
	^ self.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRRecordingRenderer >> initialize [
	super initialize.
	calls := OrderedCollection new.
]
