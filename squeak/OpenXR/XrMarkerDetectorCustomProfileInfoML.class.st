Class {
	#name : #XrMarkerDetectorCustomProfileInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrMarkerDetectorCustomProfileInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fpsHint 'XrMarkerDetectorFpsML')
		(resolutionHint 'XrMarkerDetectorResolutionML')
		(cameraHint 'XrMarkerDetectorCameraML')
		(cornerRefineMethod 'XrMarkerDetectorCornerRefineMethodML')
		(useEdgeRefinement 'XrBool32')
		(fullAnalysisIntervalHint 'XrMarkerDetectorFullAnalysisIntervalML')
	)
]
