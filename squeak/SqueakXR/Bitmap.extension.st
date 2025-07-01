Extension { #name : #Bitmap }

{ #category : #'*SqueakXR-core' }
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
	blt combinationRule: Form reverse.  "XOR"
	blt sourceY: 0; destY: 0; height: bytes size; width: 1.
	blt sourceX: 0; destX: 3; copyBits.  "Exchange bytes 0 and 3"
	blt sourceX: 3; destX: 0; copyBits.
	blt sourceX: 0; destX: 3; copyBits.
	blt sourceX: 1; destX: 2; copyBits.  "Exchange bytes 1 and 2"
	blt sourceX: 2; destX: 1; copyBits.
	blt sourceX: 1; destX: 2; copyBits.
	blt sourceX: 0; destX: 2; copyBits.  "Exchange bytes 0 and 2"
	blt sourceX: 2; destX: 0; copyBits.
	blt sourceX: 0; destX: 2; copyBits.

	"f displayOn: hack."
	^ bytes.

]
