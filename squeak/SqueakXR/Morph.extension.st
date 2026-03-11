Extension { #name : #Morph }

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 2/17/2026 18:45'
}
Morph >> isInMorphPanel [

	^ self valueOfProperty: #isInMorphPanel ifAbsent: [false]
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 2/23/2026 17:37'
}
Morph >> setIsInMorphPanel [

	^ self setProperty: #isInMorphPanel toValue: true
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/11/2026 17:55'
}
Morph >> worldDrewIn: aRectangle [

	self isInMorphPanel ifFalse: [^ self].
	self changed: #worldDrawn with: aRectangle
	
]
