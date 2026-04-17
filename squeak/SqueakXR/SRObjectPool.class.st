Class {
	#name : #SRObjectPool,
	#superclass : #Object,
	#instVars : [
		'pool',
		'poolClass',
		'size',
		'objectChain',
		'nextObjectIndex',
		'nextPool'
	],
	#category : #'SqueakXR-Pool'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 11:31'
}
SRObjectPool class >> createFor: poolClass withSize: anInteger [

	^ SRObjectPool new
		poolClass: poolClass;
		size: anInteger;
		allocate
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 13:19'
}
SRObjectPool >> allocate [

	self assert: self isPoolClassExternal
		description: 'not yet implemented for other kinds of objects'.
	
	pool := self poolClass allocateExternal: self size.
	objectChain := (2 to: self size + 1) as: IntegerArray.
	objectChain at: self size put: -1.
	nextObjectIndex := 1.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 16:57'
}
SRObjectPool >> createNextPool [

	Transcript showln: 'creating a new pool for ', self poolClass name.
	^ SRObjectPool
		createFor: self poolClass
		withSize: self size
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 11:32'
}
SRObjectPool >> finalize [

	(pool notNil and: [self isPoolClassExternal]) ifTrue: [
		pool free]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 13:10'
}
SRObjectPool >> isPoolClassExternal [

	^ self poolClass inheritsFrom: ExternalStructure
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 17:01'
}
SRObjectPool >> nextObject [

	| nextObject outIndex |
	nextObjectIndex = -1 ifTrue: [^ self nextPool nextObject].
	
	nextObject := pool at: nextObjectIndex.
	outIndex := nextObjectIndex.
	nextObjectIndex := objectChain at: nextObjectIndex.
	objectChain at: outIndex put: -1.
	^ {nextObject. outIndex. self}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 16:55'
}
SRObjectPool >> nextPool [

	^ nextPool ifNil: [nextPool := self createNextPool]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/6/2026 20:26'
}
SRObjectPool >> poolClass [

	^ poolClass
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/6/2026 20:26'
}
SRObjectPool >> poolClass: aClass [

	poolClass := aClass
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/7/2026 14:04'
}
SRObjectPool >> release: anObject [

	"assumes
	self assert: (pool includes: anObject)"
	objectChain at: anObject internalIndex put: nextObjectIndex.
	nextObjectIndex := anObject internalIndex.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/6/2026 20:26'
}
SRObjectPool >> size [

	^ size
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/6/2026 20:27'
}
SRObjectPool >> size: anInteger [

	size := anInteger
]
