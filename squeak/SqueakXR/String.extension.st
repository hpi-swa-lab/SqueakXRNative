Extension { #name : #String }

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 1/12/2026 12:02'
}
String >> screamingSnakeCaseToCamelCase [

	^ ((self findTokens: '_')
		collect: [:s | s asLowercase capitalized])
		join withFirstCharacterDownshifted
]
