Class {
	#name : #SRAudioObject,
	#superclass : #Object,
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:05'
}
SRAudioObject class >> initialize [

	" self initialize "

	super initialize.
	Smalltalk addToShutDownList: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:05'
}
SRAudioObject class >> shutDown: quitting [

	quitting ifFalse: [^ self].
	SRAudioObject allSubclasses collect: [:ea |
		ea allInstances do: #cleanup].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 17:11'
}
SRAudioObject >> cleanup [

	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 17:16'
}
SRAudioObject >> finalize [

	self cleanup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 17:10'
}
SRAudioObject >> initialize [

	super initialize.
	FinalizationRegistry default add: self.
]
