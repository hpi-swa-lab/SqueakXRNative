Class {
	#name : #SRMiniHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 13:13'
}
SRMiniHalo >> initialize [

	super initialize.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 13:39'
}
SRMiniHalo >> renderOn: aRenderer [

	"Render the entire world as a small model at my position."
	| xform |
	xform := self globalTransform  * (Matrix4x4 withScale: 0.1 asVector3 ).
	aRenderer withTransform: xform do: [
		[self world allDescendantsSelect: [:obj | obj isRendering and: [obj ~= self]]
			thenDo: [:obj |
				obj renderOn: aRenderer
		]] on: Error do: [].
	]
]
