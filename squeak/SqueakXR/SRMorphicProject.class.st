Class {
	#name : #SRMorphicProject,
	#superclass : #MorphicProject,
	#instVars : [
		'startSemaphore'
	],
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:08'
}
SRMorphicProject >> initialize [

	super initialize.
	self installPasteUpAsWorld: (SRPasteUpMorph new).
	startSemaphore := Semaphore new.
	self world
		when: #aboutToEnterWorld
		send: #signalStart
		to: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:37'
}
SRMorphicProject >> showZoom [

	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:09'
}
SRMorphicProject >> signalStart [

	self world color: Color midnight.
	startSemaphore signal
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:56'
}
SRMorphicProject >> waitForStart [

	startSemaphore wait
]
