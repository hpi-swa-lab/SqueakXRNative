"
An SRMesh holds mesh data.
"
Class {
	#name : #SRMesh,
	#superclass : #Object,
	#instVars : [
		'internalMesh',
		'source'
	],
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'lege 7/7/2026 12:06'
}
SRMesh class >> withSource: aMeshSource [

	^ self new source: aMeshSource
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:50'
}
SRMesh >> internalMesh [

	^ internalMesh ifNil: [internalMesh := self source createInternalMesh]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/15/2026 12:51'
}
SRMesh >> onCacheInvalidated [

	internalMesh := nil.
	source ifNotNil: [source onCacheInvalidated].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/7/2026 12:07'
}
SRMesh >> source [

	^ source
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 19:06'
}
SRMesh >> source: aMeshSource [

	source ifNotNil: [source removeDependent: self].
	source := aMeshSource.
	source addDependent: self.
	internalMesh := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 19:02'
}
SRMesh >> update: aSymbol [

	aSymbol = #meshChanged ifTrue: [
		internalMesh := nil]
]
