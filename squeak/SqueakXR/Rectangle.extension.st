Extension { #name : #Rectangle }

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 2/18/2026 16:40'
}
Rectangle >> relativeTo: aRectangle [

	^ Rectangle
		origin: self origin - aRectangle origin
		extent: self extent
]
