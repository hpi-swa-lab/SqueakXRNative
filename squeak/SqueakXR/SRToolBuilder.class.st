Class {
	#name : #SRToolBuilder,
	#superclass : #ToolBuilder,
	#category : #'SqueakXR-Other'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:00'
}
SRToolBuilder class >> planeOffset [

	^ 0 @ 0.001 @ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 15:41'
}
SRToolBuilder class >> widgetScale [

	^ 0.003
]

{
	#category : #'widgets required',
	#'squeak_changestamp' : 'lege 3/26/2026 15:55'
}
SRToolBuilder >> asFrame: aRectangle [
	| frame |
	aRectangle ifNil:[^nil].
	frame := LayoutFrame new.
	frame 
		leftFraction: aRectangle left; 
		rightFraction: aRectangle right; 
		topFraction: aRectangle top; 
		bottomFraction: aRectangle bottom.
	^frame
]

{
	#category : #'widgets required',
	#'squeak_changestamp' : 'lege 3/26/2026 17:33'
}
SRToolBuilder >> buildPluggableButton: aPluggableButtonSpec [ 
	
	
	| widget |
	widget := SRButton new.
	
	self setFrame: aPluggableButtonSpec frame in: widget.
	widget translation: widget translation + self class planeOffset.
	
	self parent addChild: widget.
	
	^ widget
]

{
	#category : #'widgets required',
	#'squeak_changestamp' : 'lege 3/26/2026 17:31'
}
SRToolBuilder >> buildPluggableList: aPluggableListSpec [ 
	
	| widget |
	widget := SRList new.
	
	self setFrame: aPluggableListSpec frame in: widget.
	widget translation: widget translation + self class planeOffset.
	
	self parent addChild: widget.
	
	^ widget
]

{
	#category : #'widgets required',
	#'squeak_changestamp' : 'lege 3/26/2026 17:27'
}
SRToolBuilder >> buildPluggableText: aPluggableTextSpec [

	| widget |
	widget := SRTextField new.
	
	self setFrame: aPluggableTextSpec frame in: widget.
	widget translation: widget translation + self class planeOffset.
	
	self parent addChild: widget.
	
	^ widget
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:11'
}
SRToolBuilder >> buildPluggableWindow: aSpec [

	| widget extent |
	extent := aSpec extent ifNil: [650 @ 425].
	widget := SRPlane new scale: ((self class widgetScale * extent) @ 1) xzy.
	
	"widget transform: XRWorld camera globalTransform
			* (Matrix4x4 withOffset: Vector3 forward * 1.25)."
	widget
		rotation: (Quaternion angle: 90 axis: Vector3 right);
		name: (aSpec label isSymbol
			ifTrue: [aSpec model perform: aSpec label]
			ifFalse: [aSpec label ifNil: ['a windoW']]).
	
	self buildAll: aSpec children in: widget.
	
	^ widget
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 17:14'
}
SRToolBuilder >> open: anObject [

	^ self currentXRWorld addChild: (self build: anObject)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:45'
}
SRToolBuilder >> setFrame: aRectangle in: element [ 
	
	| frame size |
	aRectangle ifNil: [^ nil].
	frame := aRectangle isRectangle
		ifTrue: [self asFrame: aRectangle]
		ifFalse: [aRectangle].
	
	size := ((frame rightFraction - frame leftFraction) @ (frame bottomFraction - frame topFraction)) asVector.
	element
		translation: ((size - 1 / 2) + (frame leftFraction @ frame topFraction) asVector) xoy;
		scale: size xiy.
]
