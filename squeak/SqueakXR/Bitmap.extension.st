Extension { #name : #Bitmap }

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 3/11/2026 17:55'
}
Bitmap >> asRGBAByteArray [
	"Adapted from Bitmap>>asByteArray and Bitmap class>>swapBytesIn:from:to:"
	| f bytes hack blt |
	f := Form extent: 4@self size depth: 8 bits: self.
	bytes := ByteArray new: self size * 4.
	hack := Form new hackBits: bytes.
	Smalltalk isLittleEndian ifTrue:[hack swapEndianness].
	hack copyBits: f boundingBox
		from: f
		at: (0@0)
		clippingBox: hack boundingBox
		rule: Form over
		fillColor: nil
		map: nil.
	
	blt := (BitBlt toForm: hack) sourceForm: hack.
	blt sourceY: 0; destY: 0; height: bytes size; width: 1.
	^ bytes

]
