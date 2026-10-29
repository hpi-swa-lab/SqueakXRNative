Class {
	#name : #SRHaloAnchor,
	#superclass : #Object,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:08'
}
SRHaloAnchor class >> all [
	^(self class methodDict keys 
		reject: [:name | name = 'all' or: name = 'default' ]) collect: [:each |
		self perform: each
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:08'
}
SRHaloAnchor class >> default [
	^ self lineOfSight 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:01'
}
SRHaloAnchor class >> lineOfSight [
	"Place Halo between the user's head and the center point and stay there."
	^'lineOfSight'
]
