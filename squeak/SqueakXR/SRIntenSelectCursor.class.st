"
Points at the target chosen by an SRIntenSelect.
"
Class {
	#name : #SRIntenSelectCursor,
	#superclass : #SRCursor,
	#instVars : [
		'selector',
		'intersections'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:29'
}
SRIntenSelectCursor >> initialize [

	super initialize.
	intersections := #().
	selector := SRIntenSelect new.
	self addChild: selector.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:38'
}
SRIntenSelectCursor >> intersectionAt: aProximity [

	^ SRIntersectionResult new
		object: aProximity object;
		point: aProximity point;
		distance: (aProximity point distanceTo: self globalTranslation);
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:29'
}
SRIntenSelectCursor >> intersections [

	^ intersections
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 16:29'
}
SRIntenSelectCursor >> updateActions: actionState [

	intersections := selector targetProximity
		ifNil: [#()]
		ifNotNil: [:proximity | {self intersectionAt: proximity}].
]
