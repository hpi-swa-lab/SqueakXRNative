Class {
	#name : #XrInteractionProfileDpadBindingEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrInteractionProfileDpadBindingEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(binding 'XrPath')
		(actionSet 'XrActionSet')
		(forceThreshold 'float')
		(forceThresholdReleased 'float')
		(centerRegion 'float')
		(wedgeAngle 'float')
		(isSticky 'XrBool32')
		(onHaptic 'XrHapticBaseHeader*')
		(offHaptic 'XrHapticBaseHeader*')
	)
]
