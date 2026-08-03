Extension { #name : #SequenceableCollection }

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 7/30/2026 18:39'
}
SequenceableCollection >> lexicographicCompare: otherCollection [

	| otherSize selfSize |
	selfSize := self size.
	otherSize := otherCollection size.
	
	1 to: (selfSize min: otherSize) do: [:index || otherElement selfElement |
		selfElement := self at: index.
		otherElement := otherCollection at: index.
		selfElement < otherElement ifTrue: [^ #less].
		selfElement > otherElement ifTrue: [^ #greater]].
	
	selfSize < otherSize ifTrue: [^ #less].
	selfSize > otherSize ifTrue: [^ #greater].
	
	^ #equal

	
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 7/30/2026 18:40'
}
SequenceableCollection >> lexicographicGreaterOrEqualTo: otherCollection [

	^ (self lexicographicCompare: otherCollection) ~= #lesser
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 7/30/2026 18:39'
}
SequenceableCollection >> lexicographicGreaterThan: otherCollection [

	^ (self lexicographicCompare: otherCollection) = #greater
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 7/30/2026 18:40'
}
SequenceableCollection >> lexicographicLessOrEqualTo: otherCollection [

	^ (self lexicographicCompare: otherCollection) ~= #greater
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 7/30/2026 18:39'
}
SequenceableCollection >> lexicographicLessThan: otherCollection [

	^ (self lexicographicCompare: otherCollection) = #less
]
