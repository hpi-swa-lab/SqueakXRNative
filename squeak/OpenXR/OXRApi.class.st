Class {
	#name : #OXRApi,
	#superclass : #ExternalLibrary,
	#category : #'OpenXR-Classes-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi class >> moduleName [

	^ 'libvulkan'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrAcquireEnvironmentDepthImageMETA: environmentDepthProvider with: acquireInfo with: environmentDepthImage [

	<apicall: XrResult 'xrAcquireEnvironmentDepthImageMETA' (XrEnvironmentDepthProviderMETA XrEnvironmentDepthImageAcquireInfoMETA* XrEnvironmentDepthImageMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrAcquireSwapchainImage: swapchain with: acquireInfo with: index [

	<apicall: XrResult 'xrAcquireSwapchainImage' (XrSwapchain XrSwapchainImageAcquireInfo* uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrAllocateWorldMeshBufferML: detector with: size with: buffer [

	<apicall: XrResult 'xrAllocateWorldMeshBufferML' (XrWorldMeshDetectorML XrWorldMeshBufferSizeML* XrWorldMeshBufferML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrApplyForceFeedbackCurlMNDX: handTracker with: locations [

	<apicall: XrResult 'xrApplyForceFeedbackCurlMNDX' (XrHandTrackerEXT XrForceFeedbackCurlApplyLocationsMNDX*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrApplyFoveationHTC: session with: applyInfo [

	<apicall: XrResult 'xrApplyFoveationHTC' (XrSession XrFoveationApplyInfoHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrApplyHapticFeedback: session with: hapticActionInfo with: hapticFeedback [

	<apicall: XrResult 'xrApplyHapticFeedback' (XrSession XrHapticActionInfo* XrHapticBaseHeader*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrAttachSessionActionSets: session with: attachInfo [

	<apicall: XrResult 'xrAttachSessionActionSets' (XrSession XrSessionActionSetsAttachInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrBeginFrame: session with: frameBeginInfo [

	<apicall: XrResult 'xrBeginFrame' (XrSession XrFrameBeginInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrBeginPlaneDetectionEXT: planeDetector with: beginInfo [

	<apicall: XrResult 'xrBeginPlaneDetectionEXT' (XrPlaneDetectorEXT XrPlaneDetectorBeginInfoEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrBeginSession: session with: beginInfo [

	<apicall: XrResult 'xrBeginSession' (XrSession XrSessionBeginInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCancelFutureEXT: instance with: cancelInfo [

	<apicall: XrResult 'xrCancelFutureEXT' (XrInstance XrFutureCancelInfoEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrChangeVirtualKeyboardTextContextMETA: keyboard with: changeInfo [

	<apicall: XrResult 'xrChangeVirtualKeyboardTextContextMETA' (XrVirtualKeyboardMETA XrVirtualKeyboardTextContextChangeInfoMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrClearSpatialAnchorStoreMSFT: spatialAnchorStore [

	<apicall: XrResult 'xrClearSpatialAnchorStoreMSFT' (XrSpatialAnchorStoreConnectionMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrComputeNewSceneMSFT: sceneObserver with: computeInfo [

	<apicall: XrResult 'xrComputeNewSceneMSFT' (XrSceneObserverMSFT XrNewSceneComputeInfoMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrConvertTimeToTimespecTimeKHR: instance with: time with: timespecTime [

	<apicall: XrResult 'xrConvertTimeToTimespecTimeKHR' (XrInstance XrTime structtimespec*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrConvertTimeToWin32PerformanceCounterKHR: instance with: time with: performanceCounter [

	<apicall: XrResult 'xrConvertTimeToWin32PerformanceCounterKHR' (XrInstance XrTime LARGE_INTEGER*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrConvertTimespecTimeToTimeKHR: instance with: timespecTime with: time [

	<apicall: XrResult 'xrConvertTimespecTimeToTimeKHR' (XrInstance structtimespec* XrTime*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrConvertWin32PerformanceCounterToTimeKHR: instance with: performanceCounter with: time [

	<apicall: XrResult 'xrConvertWin32PerformanceCounterToTimeKHR' (XrInstance LARGE_INTEGER* XrTime*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateAction: actionSet with: createInfo with: action [

	<apicall: XrResult 'xrCreateAction' (XrActionSet XrActionCreateInfo* XrAction*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateActionSet: instance with: createInfo with: actionSet [

	<apicall: XrResult 'xrCreateActionSet' (XrInstance XrActionSetCreateInfo* XrActionSet*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateActionSpace: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateActionSpace' (XrSession XrActionSpaceCreateInfo* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateApiLayerInstance: info with: layerInfo with: instance [

	<apicall: XrResult 'xrCreateApiLayerInstance' (XrInstanceCreateInfo* XrApiLayerCreateInfo* XrInstance*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateBodyTrackerBD: session with: createInfo with: bodyTracker [

	<apicall: XrResult 'xrCreateBodyTrackerBD' (XrSession XrBodyTrackerCreateInfoBD* XrBodyTrackerBD*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateBodyTrackerFB: session with: createInfo with: bodyTracker [

	<apicall: XrResult 'xrCreateBodyTrackerFB' (XrSession XrBodyTrackerCreateInfoFB* XrBodyTrackerFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateBodyTrackerHTC: session with: createInfo with: bodyTracker [

	<apicall: XrResult 'xrCreateBodyTrackerHTC' (XrSession XrBodyTrackerCreateInfoHTC* XrBodyTrackerHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateDebugUtilsMessengerEXT: instance with: createInfo with: messenger [

	<apicall: XrResult 'xrCreateDebugUtilsMessengerEXT' (XrInstance XrDebugUtilsMessengerCreateInfoEXT* XrDebugUtilsMessengerEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateEnvironmentDepthProviderMETA: session with: createInfo with: environmentDepthProvider [

	<apicall: XrResult 'xrCreateEnvironmentDepthProviderMETA' (XrSession XrEnvironmentDepthProviderCreateInfoMETA* XrEnvironmentDepthProviderMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateEnvironmentDepthSwapchainMETA: environmentDepthProvider with: createInfo with: swapchain [

	<apicall: XrResult 'xrCreateEnvironmentDepthSwapchainMETA' (XrEnvironmentDepthProviderMETA XrEnvironmentDepthSwapchainCreateInfoMETA* XrEnvironmentDepthSwapchainMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateExportedLocalizationMapML: session with: mapUuid with: map [

	<apicall: XrResult 'xrCreateExportedLocalizationMapML' (XrSession XrUuidEXT* XrExportedLocalizationMapML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateEyeTrackerFB: session with: createInfo with: eyeTracker [

	<apicall: XrResult 'xrCreateEyeTrackerFB' (XrSession XrEyeTrackerCreateInfoFB* XrEyeTrackerFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateFaceTracker2FB: session with: createInfo with: faceTracker [

	<apicall: XrResult 'xrCreateFaceTracker2FB' (XrSession XrFaceTrackerCreateInfo2FB* XrFaceTracker2FB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateFaceTrackerFB: session with: createInfo with: faceTracker [

	<apicall: XrResult 'xrCreateFaceTrackerFB' (XrSession XrFaceTrackerCreateInfoFB* XrFaceTrackerFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateFacialExpressionClientML: session with: createInfo with: facialExpressionClient [

	<apicall: XrResult 'xrCreateFacialExpressionClientML' (XrSession XrFacialExpressionClientCreateInfoML* XrFacialExpressionClientML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateFacialTrackerHTC: session with: createInfo with: facialTracker [

	<apicall: XrResult 'xrCreateFacialTrackerHTC' (XrSession XrFacialTrackerCreateInfoHTC* XrFacialTrackerHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateFoveationProfileFB: session with: createInfo with: profile [

	<apicall: XrResult 'xrCreateFoveationProfileFB' (XrSession XrFoveationProfileCreateInfoFB* XrFoveationProfileFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateGeometryInstanceFB: session with: createInfo with: outGeometryInstance [

	<apicall: XrResult 'xrCreateGeometryInstanceFB' (XrSession XrGeometryInstanceCreateInfoFB* XrGeometryInstanceFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateHandMeshSpaceMSFT: handTracker with: createInfo with: space [

	<apicall: XrResult 'xrCreateHandMeshSpaceMSFT' (XrHandTrackerEXT XrHandMeshSpaceCreateInfoMSFT* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateHandTrackerEXT: session with: createInfo with: handTracker [

	<apicall: XrResult 'xrCreateHandTrackerEXT' (XrSession XrHandTrackerCreateInfoEXT* XrHandTrackerEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateInstance: createInfo with: instance [

	<apicall: XrResult 'xrCreateInstance' (XrInstanceCreateInfo* XrInstance*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateKeyboardSpaceFB: session with: createInfo with: keyboardSpace [

	<apicall: XrResult 'xrCreateKeyboardSpaceFB' (XrSession XrKeyboardSpaceCreateInfoFB* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateMarkerDetectorML: session with: createInfo with: markerDetector [

	<apicall: XrResult 'xrCreateMarkerDetectorML' (XrSession XrMarkerDetectorCreateInfoML* XrMarkerDetectorML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateMarkerSpaceML: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateMarkerSpaceML' (XrSession XrMarkerSpaceCreateInfoML* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateMarkerSpaceVARJO: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateMarkerSpaceVARJO' (XrSession XrMarkerSpaceCreateInfoVARJO* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreatePassthroughColorLutMETA: passthrough with: createInfo with: colorLut [

	<apicall: XrResult 'xrCreatePassthroughColorLutMETA' (XrPassthroughFB XrPassthroughColorLutCreateInfoMETA* XrPassthroughColorLutMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreatePassthroughFB: session with: createInfo with: outPassthrough [

	<apicall: XrResult 'xrCreatePassthroughFB' (XrSession XrPassthroughCreateInfoFB* XrPassthroughFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreatePassthroughHTC: session with: createInfo with: passthrough [

	<apicall: XrResult 'xrCreatePassthroughHTC' (XrSession XrPassthroughCreateInfoHTC* XrPassthroughHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreatePassthroughLayerFB: session with: createInfo with: outLayer [

	<apicall: XrResult 'xrCreatePassthroughLayerFB' (XrSession XrPassthroughLayerCreateInfoFB* XrPassthroughLayerFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreatePlaneDetectorEXT: session with: createInfo with: planeDetector [

	<apicall: XrResult 'xrCreatePlaneDetectorEXT' (XrSession XrPlaneDetectorCreateInfoEXT* XrPlaneDetectorEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateReferenceSpace: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateReferenceSpace' (XrSession XrReferenceSpaceCreateInfo* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSceneMSFT: sceneObserver with: createInfo with: scene [

	<apicall: XrResult 'xrCreateSceneMSFT' (XrSceneObserverMSFT XrSceneCreateInfoMSFT* XrSceneMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSceneObserverMSFT: session with: createInfo with: sceneObserver [

	<apicall: XrResult 'xrCreateSceneObserverMSFT' (XrSession XrSceneObserverCreateInfoMSFT* XrSceneObserverMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSession: instance with: createInfo with: session [

	<apicall: XrResult 'xrCreateSession' (XrInstance XrSessionCreateInfo* XrSession*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpaceFromCoordinateFrameUIDML: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateSpaceFromCoordinateFrameUIDML' (XrSession XrCoordinateSpaceCreateInfoML* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpaceUserFB: session with: info with: user [

	<apicall: XrResult 'xrCreateSpaceUserFB' (XrSession XrSpaceUserCreateInfoFB* XrSpaceUserFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorFB: session with: info with: requestId [

	<apicall: XrResult 'xrCreateSpatialAnchorFB' (XrSession XrSpatialAnchorCreateInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorFromPerceptionAnchorMSFT: session with: perceptionAnchor with: anchor [

	<apicall: XrResult 'xrCreateSpatialAnchorFromPerceptionAnchorMSFT' (XrSession IUnknown* XrSpatialAnchorMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorFromPersistedNameMSFT: session with: spatialAnchorCreateInfo with: spatialAnchor [

	<apicall: XrResult 'xrCreateSpatialAnchorFromPersistedNameMSFT' (XrSession XrSpatialAnchorFromPersistedAnchorCreateInfoMSFT* XrSpatialAnchorMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorHTC: session with: createInfo with: anchor [

	<apicall: XrResult 'xrCreateSpatialAnchorHTC' (XrSession XrSpatialAnchorCreateInfoHTC* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorMSFT: session with: createInfo with: anchor [

	<apicall: XrResult 'xrCreateSpatialAnchorMSFT' (XrSession XrSpatialAnchorCreateInfoMSFT* XrSpatialAnchorMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorSpaceMSFT: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateSpatialAnchorSpaceMSFT' (XrSession XrSpatialAnchorSpaceCreateInfoMSFT* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorStoreConnectionMSFT: session with: spatialAnchorStore [

	<apicall: XrResult 'xrCreateSpatialAnchorStoreConnectionMSFT' (XrSession XrSpatialAnchorStoreConnectionMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorsAsyncML: session with: createInfo with: future [

	<apicall: XrResult 'xrCreateSpatialAnchorsAsyncML' (XrSession XrSpatialAnchorsCreateInfoBaseHeaderML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorsCompleteML: session with: future with: completion [

	<apicall: XrResult 'xrCreateSpatialAnchorsCompleteML' (XrSession XrFutureEXT XrCreateSpatialAnchorsCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialAnchorsStorageML: session with: createInfo with: storage [

	<apicall: XrResult 'xrCreateSpatialAnchorsStorageML' (XrSession XrSpatialAnchorsCreateStorageInfoML* XrSpatialAnchorsStorageML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSpatialGraphNodeSpaceMSFT: session with: createInfo with: space [

	<apicall: XrResult 'xrCreateSpatialGraphNodeSpaceMSFT' (XrSession XrSpatialGraphNodeSpaceCreateInfoMSFT* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSwapchain: session with: createInfo with: swapchain [

	<apicall: XrResult 'xrCreateSwapchain' (XrSession XrSwapchainCreateInfo* XrSwapchain*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateSwapchainAndroidSurfaceKHR: session with: info with: swapchain with: surface [

	<apicall: XrResult 'xrCreateSwapchainAndroidSurfaceKHR' (XrSession XrSwapchainCreateInfo* XrSwapchain* jobject*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateTriangleMeshFB: session with: createInfo with: outTriangleMesh [

	<apicall: XrResult 'xrCreateTriangleMeshFB' (XrSession XrTriangleMeshCreateInfoFB* XrTriangleMeshFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateVirtualKeyboardMETA: session with: createInfo with: keyboard [

	<apicall: XrResult 'xrCreateVirtualKeyboardMETA' (XrSession XrVirtualKeyboardCreateInfoMETA* XrVirtualKeyboardMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateVirtualKeyboardSpaceMETA: session with: keyboard with: createInfo with: keyboardSpace [

	<apicall: XrResult 'xrCreateVirtualKeyboardSpaceMETA' (XrSession XrVirtualKeyboardMETA XrVirtualKeyboardSpaceCreateInfoMETA* XrSpace*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateVulkanDeviceKHR: instance with: createInfo with: vulkanDevice with: vulkanResult [

	<apicall: XrResult 'xrCreateVulkanDeviceKHR' (XrInstance XrVulkanDeviceCreateInfoKHR* VkDevice* VkResult*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateVulkanInstanceKHR: instance with: createInfo with: vulkanInstance with: vulkanResult [

	<apicall: XrResult 'xrCreateVulkanInstanceKHR' (XrInstance XrVulkanInstanceCreateInfoKHR* VkInstance* VkResult*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrCreateWorldMeshDetectorML: session with: createInfo with: detector [

	<apicall: XrResult 'xrCreateWorldMeshDetectorML' (XrSession XrWorldMeshDetectorCreateInfoML* XrWorldMeshDetectorML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDeleteSpatialAnchorsAsyncML: storage with: deleteInfo with: future [

	<apicall: XrResult 'xrDeleteSpatialAnchorsAsyncML' (XrSpatialAnchorsStorageML XrSpatialAnchorsDeleteInfoML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDeleteSpatialAnchorsCompleteML: storage with: future with: completion [

	<apicall: XrResult 'xrDeleteSpatialAnchorsCompleteML' (XrSpatialAnchorsStorageML XrFutureEXT XrSpatialAnchorsDeleteCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDeserializeSceneMSFT: sceneObserver with: deserializeInfo [

	<apicall: XrResult 'xrDeserializeSceneMSFT' (XrSceneObserverMSFT XrSceneDeserializeInfoMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyAction: action [

	<apicall: XrResult 'xrDestroyAction' (XrAction)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyActionSet: actionSet [

	<apicall: XrResult 'xrDestroyActionSet' (XrActionSet)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyBodyTrackerBD: bodyTracker [

	<apicall: XrResult 'xrDestroyBodyTrackerBD' (XrBodyTrackerBD)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyBodyTrackerFB: bodyTracker [

	<apicall: XrResult 'xrDestroyBodyTrackerFB' (XrBodyTrackerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyBodyTrackerHTC: bodyTracker [

	<apicall: XrResult 'xrDestroyBodyTrackerHTC' (XrBodyTrackerHTC)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyDebugUtilsMessengerEXT: messenger [

	<apicall: XrResult 'xrDestroyDebugUtilsMessengerEXT' (XrDebugUtilsMessengerEXT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyEnvironmentDepthProviderMETA: environmentDepthProvider [

	<apicall: XrResult 'xrDestroyEnvironmentDepthProviderMETA' (XrEnvironmentDepthProviderMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyEnvironmentDepthSwapchainMETA: swapchain [

	<apicall: XrResult 'xrDestroyEnvironmentDepthSwapchainMETA' (XrEnvironmentDepthSwapchainMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyExportedLocalizationMapML: map [

	<apicall: XrResult 'xrDestroyExportedLocalizationMapML' (XrExportedLocalizationMapML)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyEyeTrackerFB: eyeTracker [

	<apicall: XrResult 'xrDestroyEyeTrackerFB' (XrEyeTrackerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyFaceTracker2FB: faceTracker [

	<apicall: XrResult 'xrDestroyFaceTracker2FB' (XrFaceTracker2FB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyFaceTrackerFB: faceTracker [

	<apicall: XrResult 'xrDestroyFaceTrackerFB' (XrFaceTrackerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyFacialExpressionClientML: facialExpressionClient [

	<apicall: XrResult 'xrDestroyFacialExpressionClientML' (XrFacialExpressionClientML)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyFacialTrackerHTC: facialTracker [

	<apicall: XrResult 'xrDestroyFacialTrackerHTC' (XrFacialTrackerHTC)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyFoveationProfileFB: profile [

	<apicall: XrResult 'xrDestroyFoveationProfileFB' (XrFoveationProfileFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyGeometryInstanceFB: instance [

	<apicall: XrResult 'xrDestroyGeometryInstanceFB' (XrGeometryInstanceFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyHandTrackerEXT: handTracker [

	<apicall: XrResult 'xrDestroyHandTrackerEXT' (XrHandTrackerEXT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyInstance: instance [

	<apicall: XrResult 'xrDestroyInstance' (XrInstance)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyMarkerDetectorML: markerDetector [

	<apicall: XrResult 'xrDestroyMarkerDetectorML' (XrMarkerDetectorML)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyPassthroughColorLutMETA: colorLut [

	<apicall: XrResult 'xrDestroyPassthroughColorLutMETA' (XrPassthroughColorLutMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyPassthroughFB: passthrough [

	<apicall: XrResult 'xrDestroyPassthroughFB' (XrPassthroughFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyPassthroughHTC: passthrough [

	<apicall: XrResult 'xrDestroyPassthroughHTC' (XrPassthroughHTC)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyPassthroughLayerFB: layer [

	<apicall: XrResult 'xrDestroyPassthroughLayerFB' (XrPassthroughLayerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyPlaneDetectorEXT: planeDetector [

	<apicall: XrResult 'xrDestroyPlaneDetectorEXT' (XrPlaneDetectorEXT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySceneMSFT: scene [

	<apicall: XrResult 'xrDestroySceneMSFT' (XrSceneMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySceneObserverMSFT: sceneObserver [

	<apicall: XrResult 'xrDestroySceneObserverMSFT' (XrSceneObserverMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySession: session [

	<apicall: XrResult 'xrDestroySession' (XrSession)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpace: space [

	<apicall: XrResult 'xrDestroySpace' (XrSpace)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpaceUserFB: user [

	<apicall: XrResult 'xrDestroySpaceUserFB' (XrSpaceUserFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpatialAnchorMSFT: anchor [

	<apicall: XrResult 'xrDestroySpatialAnchorMSFT' (XrSpatialAnchorMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpatialAnchorStoreConnectionMSFT: spatialAnchorStore [

	<apicall: XrResult 'xrDestroySpatialAnchorStoreConnectionMSFT' (XrSpatialAnchorStoreConnectionMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpatialAnchorsStorageML: storage [

	<apicall: XrResult 'xrDestroySpatialAnchorsStorageML' (XrSpatialAnchorsStorageML)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySpatialGraphNodeBindingMSFT: nodeBinding [

	<apicall: XrResult 'xrDestroySpatialGraphNodeBindingMSFT' (XrSpatialGraphNodeBindingMSFT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroySwapchain: swapchain [

	<apicall: XrResult 'xrDestroySwapchain' (XrSwapchain)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyTriangleMeshFB: mesh [

	<apicall: XrResult 'xrDestroyTriangleMeshFB' (XrTriangleMeshFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyVirtualKeyboardMETA: keyboard [

	<apicall: XrResult 'xrDestroyVirtualKeyboardMETA' (XrVirtualKeyboardMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrDestroyWorldMeshDetectorML: detector [

	<apicall: XrResult 'xrDestroyWorldMeshDetectorML' (XrWorldMeshDetectorML)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnableLocalizationEventsML: session with: info [

	<apicall: XrResult 'xrEnableLocalizationEventsML' (XrSession XrLocalizationEnableEventsInfoML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnableUserCalibrationEventsML: instance with: enableInfo [

	<apicall: XrResult 'xrEnableUserCalibrationEventsML' (XrInstance XrUserCalibrationEnableEventsInfoML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEndFrame: session with: frameEndInfo [

	<apicall: XrResult 'xrEndFrame' (XrSession XrFrameEndInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEndSession: session [

	<apicall: XrResult 'xrEndSession' (XrSession)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateApiLayerProperties: propertyCapacityInput with: propertyCountOutput with: properties [

	<apicall: XrResult 'xrEnumerateApiLayerProperties' (uint32_t uint32_t* XrApiLayerProperties*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateBoundSourcesForAction: session with: enumerateInfo with: sourceCapacityInput with: sourceCountOutput with: sources [

	<apicall: XrResult 'xrEnumerateBoundSourcesForAction' (XrSession XrBoundSourcesForActionEnumerateInfo* uint32_t uint32_t* XrPath*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateColorSpacesFB: session with: colorSpaceCapacityInput with: colorSpaceCountOutput with: colorSpaces [

	<apicall: XrResult 'xrEnumerateColorSpacesFB' (XrSession uint32_t uint32_t* XrColorSpaceFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateDisplayRefreshRatesFB: session with: displayRefreshRateCapacityInput with: displayRefreshRateCountOutput with: displayRefreshRates [

	<apicall: XrResult 'xrEnumerateDisplayRefreshRatesFB' (XrSession uint32_t uint32_t* float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateEnvironmentBlendModes: instance with: systemId with: viewConfigurationType with: environmentBlendModeCapacityInput with: environmentBlendModeCountOutput with: environmentBlendModes [

	<apicall: XrResult 'xrEnumerateEnvironmentBlendModes' (XrInstance XrSystemId XrViewConfigurationType uint32_t uint32_t* XrEnvironmentBlendMode*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateEnvironmentDepthSwapchainImagesMETA: swapchain with: imageCapacityInput with: imageCountOutput with: images [

	<apicall: XrResult 'xrEnumerateEnvironmentDepthSwapchainImagesMETA' (XrEnvironmentDepthSwapchainMETA uint32_t uint32_t* XrSwapchainImageBaseHeader*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateExternalCamerasOCULUS: session with: cameraCapacityInput with: cameraCountOutput with: cameras [

	<apicall: XrResult 'xrEnumerateExternalCamerasOCULUS' (XrSession uint32_t uint32_t* XrExternalCameraOCULUS*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateInstanceExtensionProperties: layerName with: propertyCapacityInput with: propertyCountOutput with: properties [

	<apicall: XrResult 'xrEnumerateInstanceExtensionProperties' (char* uint32_t uint32_t* XrExtensionProperties*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumeratePerformanceMetricsCounterPathsMETA: instance with: counterPathCapacityInput with: counterPathCountOutput with: counterPaths [

	<apicall: XrResult 'xrEnumeratePerformanceMetricsCounterPathsMETA' (XrInstance uint32_t uint32_t* XrPath*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumeratePersistedSpatialAnchorNamesMSFT: spatialAnchorStore with: spatialAnchorNameCapacityInput with: spatialAnchorNameCountOutput with: spatialAnchorNames [

	<apicall: XrResult 'xrEnumeratePersistedSpatialAnchorNamesMSFT' (XrSpatialAnchorStoreConnectionMSFT uint32_t uint32_t* XrSpatialAnchorPersistenceNameMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateReferenceSpaces: session with: spaceCapacityInput with: spaceCountOutput with: spaces [

	<apicall: XrResult 'xrEnumerateReferenceSpaces' (XrSession uint32_t uint32_t* XrReferenceSpaceType*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateRenderModelPathsFB: session with: pathCapacityInput with: pathCountOutput with: paths [

	<apicall: XrResult 'xrEnumerateRenderModelPathsFB' (XrSession uint32_t uint32_t* XrRenderModelPathInfoFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateReprojectionModesMSFT: instance with: systemId with: viewConfigurationType with: modeCapacityInput with: modeCountOutput with: modes [

	<apicall: XrResult 'xrEnumerateReprojectionModesMSFT' (XrInstance XrSystemId XrViewConfigurationType uint32_t uint32_t* XrReprojectionModeMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateSceneComputeFeaturesMSFT: instance with: systemId with: featureCapacityInput with: featureCountOutput with: features [

	<apicall: XrResult 'xrEnumerateSceneComputeFeaturesMSFT' (XrInstance XrSystemId uint32_t uint32_t* XrSceneComputeFeatureMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateSpaceSupportedComponentsFB: space with: componentTypeCapacityInput with: componentTypeCountOutput with: componentTypes [

	<apicall: XrResult 'xrEnumerateSpaceSupportedComponentsFB' (XrSpace uint32_t uint32_t* XrSpaceComponentTypeFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateSwapchainFormats: session with: formatCapacityInput with: formatCountOutput with: formats [

	<apicall: XrResult 'xrEnumerateSwapchainFormats' (XrSession uint32_t uint32_t* int64_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateSwapchainImages: swapchain with: imageCapacityInput with: imageCountOutput with: images [

	<apicall: XrResult 'xrEnumerateSwapchainImages' (XrSwapchain uint32_t uint32_t* XrSwapchainImageBaseHeader*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateViewConfigurationViews: instance with: systemId with: viewConfigurationType with: viewCapacityInput with: viewCountOutput with: views [

	<apicall: XrResult 'xrEnumerateViewConfigurationViews' (XrInstance XrSystemId XrViewConfigurationType uint32_t uint32_t* XrViewConfigurationView*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateViewConfigurations: instance with: systemId with: viewConfigurationTypeCapacityInput with: viewConfigurationTypeCountOutput with: viewConfigurationTypes [

	<apicall: XrResult 'xrEnumerateViewConfigurations' (XrInstance XrSystemId uint32_t uint32_t* XrViewConfigurationType*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEnumerateViveTrackerPathsHTCX: instance with: pathCapacityInput with: pathCountOutput with: paths [

	<apicall: XrResult 'xrEnumerateViveTrackerPathsHTCX' (XrInstance uint32_t uint32_t* XrViveTrackerPathsHTCX*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrEraseSpaceFB: session with: info with: requestId [

	<apicall: XrResult 'xrEraseSpaceFB' (XrSession XrSpaceEraseInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrFreeWorldMeshBufferML: detector with: buffer [

	<apicall: XrResult 'xrFreeWorldMeshBufferML' (XrWorldMeshDetectorML XrWorldMeshBufferML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGeometryInstanceSetTransformFB: instance with: transformation [

	<apicall: XrResult 'xrGeometryInstanceSetTransformFB' (XrGeometryInstanceFB XrGeometryInstanceTransformFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetActionStateBoolean: session with: getInfo with: state [

	<apicall: XrResult 'xrGetActionStateBoolean' (XrSession XrActionStateGetInfo* XrActionStateBoolean*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetActionStateFloat: session with: getInfo with: state [

	<apicall: XrResult 'xrGetActionStateFloat' (XrSession XrActionStateGetInfo* XrActionStateFloat*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetActionStatePose: session with: getInfo with: state [

	<apicall: XrResult 'xrGetActionStatePose' (XrSession XrActionStateGetInfo* XrActionStatePose*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetActionStateVector2f: session with: getInfo with: state [

	<apicall: XrResult 'xrGetActionStateVector2f' (XrSession XrActionStateGetInfo* XrActionStateVector2f*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetAudioInputDeviceGuidOculus: instance with: buffer [

	<apicall: XrResult 'xrGetAudioInputDeviceGuidOculus' (XrInstance wchar_t[])>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetAudioOutputDeviceGuidOculus: instance with: buffer [

	<apicall: XrResult 'xrGetAudioOutputDeviceGuidOculus' (XrInstance wchar_t[])>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetBodySkeletonFB: bodyTracker with: skeleton [

	<apicall: XrResult 'xrGetBodySkeletonFB' (XrBodyTrackerFB XrBodySkeletonFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetBodySkeletonHTC: bodyTracker with: baseSpace with: skeletonGenerationId with: skeleton [

	<apicall: XrResult 'xrGetBodySkeletonHTC' (XrBodyTrackerHTC XrSpace uint32_t XrBodySkeletonHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetControllerModelKeyMSFT: session with: topLevelUserPath with: controllerModelKeyState [

	<apicall: XrResult 'xrGetControllerModelKeyMSFT' (XrSession XrPath XrControllerModelKeyStateMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetControllerModelPropertiesMSFT: session with: modelKey with: properties [

	<apicall: XrResult 'xrGetControllerModelPropertiesMSFT' (XrSession XrControllerModelKeyMSFT XrControllerModelPropertiesMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetControllerModelStateMSFT: session with: modelKey with: state [

	<apicall: XrResult 'xrGetControllerModelStateMSFT' (XrSession XrControllerModelKeyMSFT XrControllerModelStateMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetCurrentInteractionProfile: session with: topLevelUserPath with: interactionProfile [

	<apicall: XrResult 'xrGetCurrentInteractionProfile' (XrSession XrPath XrInteractionProfileState*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetD3D11GraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetD3D11GraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsD3D11KHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetD3D12GraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetD3D12GraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsD3D12KHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetDeviceSampleRateFB: session with: hapticActionInfo with: deviceSampleRate [

	<apicall: XrResult 'xrGetDeviceSampleRateFB' (XrSession XrHapticActionInfo* XrDevicePcmSampleRateGetInfoFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetDisplayRefreshRateFB: session with: displayRefreshRate [

	<apicall: XrResult 'xrGetDisplayRefreshRateFB' (XrSession float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetEnvironmentDepthSwapchainStateMETA: swapchain with: state [

	<apicall: XrResult 'xrGetEnvironmentDepthSwapchainStateMETA' (XrEnvironmentDepthSwapchainMETA XrEnvironmentDepthSwapchainStateMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetExportedLocalizationMapDataML: map with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetExportedLocalizationMapDataML' (XrExportedLocalizationMapML uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetEyeGazesFB: eyeTracker with: gazeInfo with: eyeGazes [

	<apicall: XrResult 'xrGetEyeGazesFB' (XrEyeTrackerFB XrEyeGazesInfoFB* XrEyeGazesFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetFaceExpressionWeights2FB: faceTracker with: expressionInfo with: expressionWeights [

	<apicall: XrResult 'xrGetFaceExpressionWeights2FB' (XrFaceTracker2FB XrFaceExpressionInfo2FB* XrFaceExpressionWeights2FB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetFaceExpressionWeightsFB: faceTracker with: expressionInfo with: expressionWeights [

	<apicall: XrResult 'xrGetFaceExpressionWeightsFB' (XrFaceTrackerFB XrFaceExpressionInfoFB* XrFaceExpressionWeightsFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetFacialExpressionBlendShapePropertiesML: facialExpressionClient with: blendShapeGetInfo with: blendShapeCount with: blendShapes [

	<apicall: XrResult 'xrGetFacialExpressionBlendShapePropertiesML' (XrFacialExpressionClientML XrFacialExpressionBlendShapeGetInfoML* uint32_t XrFacialExpressionBlendShapePropertiesML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetFacialExpressionsHTC: facialTracker with: facialExpressions [

	<apicall: XrResult 'xrGetFacialExpressionsHTC' (XrFacialTrackerHTC XrFacialExpressionsHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetFoveationEyeTrackedStateMETA: session with: foveationState [

	<apicall: XrResult 'xrGetFoveationEyeTrackedStateMETA' (XrSession XrFoveationEyeTrackedStateMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetHandMeshFB: handTracker with: mesh [

	<apicall: XrResult 'xrGetHandMeshFB' (XrHandTrackerEXT XrHandTrackingMeshFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetInputSourceLocalizedName: session with: getInfo with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetInputSourceLocalizedName' (XrSession XrInputSourceLocalizedNameGetInfo* uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetInstanceProcAddr: instance with: name with: function [

	<apicall: XrResult 'xrGetInstanceProcAddr' (XrInstance char* PFN_xrVoidFunction*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetInstanceProperties: instance with: instanceProperties [

	<apicall: XrResult 'xrGetInstanceProperties' (XrInstance XrInstanceProperties*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerDetectorStateML: markerDetector with: state [

	<apicall: XrResult 'xrGetMarkerDetectorStateML' (XrMarkerDetectorML XrMarkerDetectorStateML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerLengthML: markerDetector with: marker with: meters [

	<apicall: XrResult 'xrGetMarkerLengthML' (XrMarkerDetectorML XrMarkerML float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerNumberML: markerDetector with: marker with: number [

	<apicall: XrResult 'xrGetMarkerNumberML' (XrMarkerDetectorML XrMarkerML uint64_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerReprojectionErrorML: markerDetector with: marker with: reprojectionErrorMeters [

	<apicall: XrResult 'xrGetMarkerReprojectionErrorML' (XrMarkerDetectorML XrMarkerML float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerSizeVARJO: session with: markerId with: size [

	<apicall: XrResult 'xrGetMarkerSizeVARJO' (XrSession uint64_t XrExtent2Df*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkerStringML: markerDetector with: marker with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetMarkerStringML' (XrMarkerDetectorML XrMarkerML uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMarkersML: markerDetector with: markerCapacityInput with: markerCountOutput with: markers [

	<apicall: XrResult 'xrGetMarkersML' (XrMarkerDetectorML uint32_t uint32_t* XrMarkerML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetMetalGraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetMetalGraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsMetalKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetOpenGLESGraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetOpenGLESGraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsOpenGLESKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetOpenGLGraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetOpenGLGraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsOpenGLKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetPassthroughPreferencesMETA: session with: preferences [

	<apicall: XrResult 'xrGetPassthroughPreferencesMETA' (XrSession XrPassthroughPreferencesMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetPerformanceMetricsStateMETA: session with: state [

	<apicall: XrResult 'xrGetPerformanceMetricsStateMETA' (XrSession XrPerformanceMetricsStateMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetPlaneDetectionStateEXT: planeDetector with: state [

	<apicall: XrResult 'xrGetPlaneDetectionStateEXT' (XrPlaneDetectorEXT XrPlaneDetectionStateEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetPlaneDetectionsEXT: planeDetector with: info with: locations [

	<apicall: XrResult 'xrGetPlaneDetectionsEXT' (XrPlaneDetectorEXT XrPlaneDetectorGetInfoEXT* XrPlaneDetectorLocationsEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetPlanePolygonBufferEXT: planeDetector with: planeId with: polygonBufferIndex with: polygonBuffer [

	<apicall: XrResult 'xrGetPlanePolygonBufferEXT' (XrPlaneDetectorEXT uint64_t uint32_t XrPlaneDetectorPolygonBufferEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetRecommendedLayerResolutionMETA: session with: info with: resolution [

	<apicall: XrResult 'xrGetRecommendedLayerResolutionMETA' (XrSession XrRecommendedLayerResolutionGetInfoMETA* XrRecommendedLayerResolutionMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetReferenceSpaceBoundsRect: session with: referenceSpaceType with: bounds [

	<apicall: XrResult 'xrGetReferenceSpaceBoundsRect' (XrSession XrReferenceSpaceType XrExtent2Df*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetRenderModelPropertiesFB: session with: path with: properties [

	<apicall: XrResult 'xrGetRenderModelPropertiesFB' (XrSession XrPath XrRenderModelPropertiesFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSceneComponentsMSFT: scene with: getInfo with: components [

	<apicall: XrResult 'xrGetSceneComponentsMSFT' (XrSceneMSFT XrSceneComponentsGetInfoMSFT* XrSceneComponentsMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSceneComputeStateMSFT: sceneObserver with: state [

	<apicall: XrResult 'xrGetSceneComputeStateMSFT' (XrSceneObserverMSFT XrSceneComputeStateMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSceneMarkerDecodedStringMSFT: scene with: markerId with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetSceneMarkerDecodedStringMSFT' (XrSceneMSFT XrUuidMSFT* uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSceneMarkerRawDataMSFT: scene with: markerId with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetSceneMarkerRawDataMSFT' (XrSceneMSFT XrUuidMSFT* uint32_t uint32_t* uint8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSceneMeshBuffersMSFT: scene with: getInfo with: buffers [

	<apicall: XrResult 'xrGetSceneMeshBuffersMSFT' (XrSceneMSFT XrSceneMeshBuffersGetInfoMSFT* XrSceneMeshBuffersMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSerializedSceneFragmentDataMSFT: scene with: getInfo with: countInput with: readOutput with: buffer [

	<apicall: XrResult 'xrGetSerializedSceneFragmentDataMSFT' (XrSceneMSFT XrSerializedSceneFragmentDataGetInfoMSFT* uint32_t uint32_t* uint8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceBoundary2DFB: session with: space with: boundary2DOutput [

	<apicall: XrResult 'xrGetSpaceBoundary2DFB' (XrSession XrSpace XrBoundary2DFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceBoundingBox2DFB: session with: space with: boundingBox2DOutput [

	<apicall: XrResult 'xrGetSpaceBoundingBox2DFB' (XrSession XrSpace XrRect2Df*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceBoundingBox3DFB: session with: space with: boundingBox3DOutput [

	<apicall: XrResult 'xrGetSpaceBoundingBox3DFB' (XrSession XrSpace XrRect3DfFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceComponentStatusFB: space with: componentType with: status [

	<apicall: XrResult 'xrGetSpaceComponentStatusFB' (XrSpace XrSpaceComponentTypeFB XrSpaceComponentStatusFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceContainerFB: session with: space with: spaceContainerOutput [

	<apicall: XrResult 'xrGetSpaceContainerFB' (XrSession XrSpace XrSpaceContainerFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceRoomLayoutFB: session with: space with: roomLayoutOutput [

	<apicall: XrResult 'xrGetSpaceRoomLayoutFB' (XrSession XrSpace XrRoomLayoutFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceSemanticLabelsFB: session with: space with: semanticLabelsOutput [

	<apicall: XrResult 'xrGetSpaceSemanticLabelsFB' (XrSession XrSpace XrSemanticLabelsFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceTriangleMeshMETA: space with: getInfo with: triangleMeshOutput [

	<apicall: XrResult 'xrGetSpaceTriangleMeshMETA' (XrSpace XrSpaceTriangleMeshGetInfoMETA* XrSpaceTriangleMeshMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceUserIdFB: user with: userId [

	<apicall: XrResult 'xrGetSpaceUserIdFB' (XrSpaceUserFB XrSpaceUserIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpaceUuidFB: space with: uuid [

	<apicall: XrResult 'xrGetSpaceUuidFB' (XrSpace XrUuidEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpatialAnchorNameHTC: anchor with: name [

	<apicall: XrResult 'xrGetSpatialAnchorNameHTC' (XrSpace XrSpatialAnchorNameHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpatialAnchorStateML: anchor with: state [

	<apicall: XrResult 'xrGetSpatialAnchorStateML' (XrSpace XrSpatialAnchorStateML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSpatialGraphNodeBindingPropertiesMSFT: nodeBinding with: getInfo with: properties [

	<apicall: XrResult 'xrGetSpatialGraphNodeBindingPropertiesMSFT' (XrSpatialGraphNodeBindingMSFT XrSpatialGraphNodeBindingPropertiesGetInfoMSFT* XrSpatialGraphNodeBindingPropertiesMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSwapchainStateFB: swapchain with: state [

	<apicall: XrResult 'xrGetSwapchainStateFB' (XrSwapchain XrSwapchainStateBaseHeaderFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSystem: instance with: getInfo with: systemId [

	<apicall: XrResult 'xrGetSystem' (XrInstance XrSystemGetInfo* XrSystemId*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetSystemProperties: instance with: systemId with: properties [

	<apicall: XrResult 'xrGetSystemProperties' (XrInstance XrSystemId XrSystemProperties*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetViewConfigurationProperties: instance with: systemId with: viewConfigurationType with: configurationProperties [

	<apicall: XrResult 'xrGetViewConfigurationProperties' (XrInstance XrSystemId XrViewConfigurationType XrViewConfigurationProperties*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVirtualKeyboardDirtyTexturesMETA: keyboard with: textureIdCapacityInput with: textureIdCountOutput with: textureIds [

	<apicall: XrResult 'xrGetVirtualKeyboardDirtyTexturesMETA' (XrVirtualKeyboardMETA uint32_t uint32_t* uint64_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVirtualKeyboardModelAnimationStatesMETA: keyboard with: animationStates [

	<apicall: XrResult 'xrGetVirtualKeyboardModelAnimationStatesMETA' (XrVirtualKeyboardMETA XrVirtualKeyboardModelAnimationStatesMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVirtualKeyboardScaleMETA: keyboard with: scale [

	<apicall: XrResult 'xrGetVirtualKeyboardScaleMETA' (XrVirtualKeyboardMETA float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVirtualKeyboardTextureDataMETA: keyboard with: textureId with: textureData [

	<apicall: XrResult 'xrGetVirtualKeyboardTextureDataMETA' (XrVirtualKeyboardMETA uint64_t XrVirtualKeyboardTextureDataMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVisibilityMaskKHR: session with: viewConfigurationType with: viewIndex with: visibilityMaskType with: visibilityMask [

	<apicall: XrResult 'xrGetVisibilityMaskKHR' (XrSession XrViewConfigurationType uint32_t XrVisibilityMaskTypeKHR XrVisibilityMaskKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanDeviceExtensionsKHR: instance with: systemId with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetVulkanDeviceExtensionsKHR' (XrInstance XrSystemId uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanGraphicsDevice2KHR: instance with: getInfo with: vulkanPhysicalDevice [

	<apicall: XrResult 'xrGetVulkanGraphicsDevice2KHR' (XrInstance XrVulkanGraphicsDeviceGetInfoKHR* VkPhysicalDevice*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanGraphicsDeviceKHR: instance with: systemId with: vkInstance with: vkPhysicalDevice [

	<apicall: XrResult 'xrGetVulkanGraphicsDeviceKHR' (XrInstance XrSystemId VkInstance VkPhysicalDevice*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanGraphicsRequirements2KHR [
	^ self xrGetVulkanGraphicsRequirementsKHR
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanGraphicsRequirementsKHR: instance with: systemId with: graphicsRequirements [

	<apicall: XrResult 'xrGetVulkanGraphicsRequirementsKHR' (XrInstance XrSystemId XrGraphicsRequirementsVulkanKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetVulkanInstanceExtensionsKHR: instance with: systemId with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrGetVulkanInstanceExtensionsKHR' (XrInstance XrSystemId uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrGetWorldMeshBufferRecommendSizeML: detector with: sizeInfo with: size [

	<apicall: XrResult 'xrGetWorldMeshBufferRecommendSizeML' (XrWorldMeshDetectorML XrWorldMeshBufferRecommendedSizeInfoML* XrWorldMeshBufferSizeML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrImportLocalizationMapML: session with: importInfo with: mapUuid [

	<apicall: XrResult 'xrImportLocalizationMapML' (XrSession XrLocalizationMapImportInfoML* XrUuidEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrInitializeLoaderKHR: loaderInitInfo [

	<apicall: XrResult 'xrInitializeLoaderKHR' (XrLoaderInitInfoBaseHeaderKHR*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLoadControllerModelMSFT: session with: modelKey with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrLoadControllerModelMSFT' (XrSession XrControllerModelKeyMSFT uint32_t uint32_t* uint8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLoadRenderModelFB: session with: info with: buffer [

	<apicall: XrResult 'xrLoadRenderModelFB' (XrSession XrRenderModelLoadInfoFB* XrRenderModelBufferFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateBodyJointsBD: bodyTracker with: locateInfo with: locations [

	<apicall: XrResult 'xrLocateBodyJointsBD' (XrBodyTrackerBD XrBodyJointsLocateInfoBD* XrBodyJointLocationsBD*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateBodyJointsFB: bodyTracker with: locateInfo with: locations [

	<apicall: XrResult 'xrLocateBodyJointsFB' (XrBodyTrackerFB XrBodyJointsLocateInfoFB* XrBodyJointLocationsFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateBodyJointsHTC: bodyTracker with: locateInfo with: locations [

	<apicall: XrResult 'xrLocateBodyJointsHTC' (XrBodyTrackerHTC XrBodyJointsLocateInfoHTC* XrBodyJointLocationsHTC*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateHandJointsEXT: handTracker with: locateInfo with: locations [

	<apicall: XrResult 'xrLocateHandJointsEXT' (XrHandTrackerEXT XrHandJointsLocateInfoEXT* XrHandJointLocationsEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateSceneComponentsMSFT: scene with: locateInfo with: locations [

	<apicall: XrResult 'xrLocateSceneComponentsMSFT' (XrSceneMSFT XrSceneComponentsLocateInfoMSFT* XrSceneComponentLocationsMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateSpace: space with: baseSpace with: time with: location [

	<apicall: XrResult 'xrLocateSpace' (XrSpace XrSpace XrTime XrSpaceLocation*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateSpaces: session with: locateInfo with: spaceLocations [

	<apicall: XrResult 'xrLocateSpaces' (XrSession XrSpacesLocateInfo* XrSpaceLocations*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateSpacesKHR [
	^ self xrLocateSpaces
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrLocateViews: session with: viewLocateInfo with: viewState with: viewCapacityInput with: viewCountOutput with: views [

	<apicall: XrResult 'xrLocateViews' (XrSession XrViewLocateInfo* XrViewState* uint32_t uint32_t* XrView*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrNegotiateLoaderApiLayerInterface: loaderInfo with: layerName with: apiLayerRequest [

	<apicall: XrResult 'xrNegotiateLoaderApiLayerInterface' (XrNegotiateLoaderInfo* char* XrNegotiateApiLayerRequest*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrNegotiateLoaderRuntimeInterface: loaderInfo with: runtimeRequest [

	<apicall: XrResult 'xrNegotiateLoaderRuntimeInterface' (XrNegotiateLoaderInfo* XrNegotiateRuntimeRequest*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughLayerPauseFB: layer [

	<apicall: XrResult 'xrPassthroughLayerPauseFB' (XrPassthroughLayerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughLayerResumeFB: layer [

	<apicall: XrResult 'xrPassthroughLayerResumeFB' (XrPassthroughLayerFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughLayerSetKeyboardHandsIntensityFB: layer with: intensity [

	<apicall: XrResult 'xrPassthroughLayerSetKeyboardHandsIntensityFB' (XrPassthroughLayerFB XrPassthroughKeyboardHandsIntensityFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughLayerSetStyleFB: layer with: style [

	<apicall: XrResult 'xrPassthroughLayerSetStyleFB' (XrPassthroughLayerFB XrPassthroughStyleFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughPauseFB: passthrough [

	<apicall: XrResult 'xrPassthroughPauseFB' (XrPassthroughFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPassthroughStartFB: passthrough [

	<apicall: XrResult 'xrPassthroughStartFB' (XrPassthroughFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPathToString: instance with: path with: bufferCapacityInput with: bufferCountOutput with: buffer [

	<apicall: XrResult 'xrPathToString' (XrInstance XrPath uint32_t uint32_t* char*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPerfSettingsSetPerformanceLevelEXT: session with: domain with: level [

	<apicall: XrResult 'xrPerfSettingsSetPerformanceLevelEXT' (XrSession XrPerfSettingsDomainEXT XrPerfSettingsLevelEXT)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPersistSpatialAnchorMSFT: spatialAnchorStore with: spatialAnchorPersistenceInfo [

	<apicall: XrResult 'xrPersistSpatialAnchorMSFT' (XrSpatialAnchorStoreConnectionMSFT XrSpatialAnchorPersistenceInfoMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPollEvent: instance with: eventData [

	<apicall: XrResult 'xrPollEvent' (XrInstance XrEventDataBuffer*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPollFutureEXT: instance with: pollInfo with: pollResult [

	<apicall: XrResult 'xrPollFutureEXT' (XrInstance XrFuturePollInfoEXT* XrFuturePollResultEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPublishSpatialAnchorsAsyncML: storage with: publishInfo with: future [

	<apicall: XrResult 'xrPublishSpatialAnchorsAsyncML' (XrSpatialAnchorsStorageML XrSpatialAnchorsPublishInfoML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrPublishSpatialAnchorsCompleteML: storage with: future with: completion [

	<apicall: XrResult 'xrPublishSpatialAnchorsCompleteML' (XrSpatialAnchorsStorageML XrFutureEXT XrSpatialAnchorsPublishCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQueryLocalizationMapsML: session with: queryInfo with: mapCapacityInput with: mapCountOutput with: maps [

	<apicall: XrResult 'xrQueryLocalizationMapsML' (XrSession XrLocalizationMapQueryInfoBaseHeaderML* uint32_t uint32_t* XrLocalizationMapML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQueryPerformanceMetricsCounterMETA: session with: counterPath with: counter [

	<apicall: XrResult 'xrQueryPerformanceMetricsCounterMETA' (XrSession XrPath XrPerformanceMetricsCounterMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQuerySpacesFB: session with: info with: requestId [

	<apicall: XrResult 'xrQuerySpacesFB' (XrSession XrSpaceQueryInfoBaseHeaderFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQuerySpatialAnchorsAsyncML: storage with: queryInfo with: future [

	<apicall: XrResult 'xrQuerySpatialAnchorsAsyncML' (XrSpatialAnchorsStorageML XrSpatialAnchorsQueryInfoBaseHeaderML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQuerySpatialAnchorsCompleteML: storage with: future with: completion [

	<apicall: XrResult 'xrQuerySpatialAnchorsCompleteML' (XrSpatialAnchorsStorageML XrFutureEXT XrSpatialAnchorsQueryCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrQuerySystemTrackedKeyboardFB: session with: queryInfo with: keyboard [

	<apicall: XrResult 'xrQuerySystemTrackedKeyboardFB' (XrSession XrKeyboardTrackingQueryFB* XrKeyboardTrackingDescriptionFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrReleaseSwapchainImage: swapchain with: releaseInfo [

	<apicall: XrResult 'xrReleaseSwapchainImage' (XrSwapchain XrSwapchainImageReleaseInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestDisplayRefreshRateFB: session with: displayRefreshRate [

	<apicall: XrResult 'xrRequestDisplayRefreshRateFB' (XrSession float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestExitSession: session [

	<apicall: XrResult 'xrRequestExitSession' (XrSession)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestMapLocalizationML: session with: requestInfo [

	<apicall: XrResult 'xrRequestMapLocalizationML' (XrSession XrMapLocalizationRequestInfoML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestSceneCaptureFB: session with: info with: requestId [

	<apicall: XrResult 'xrRequestSceneCaptureFB' (XrSession XrSceneCaptureRequestInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestWorldMeshAsyncML: detector with: getInfo with: buffer with: future [

	<apicall: XrResult 'xrRequestWorldMeshAsyncML' (XrWorldMeshDetectorML XrWorldMeshGetInfoML* XrWorldMeshBufferML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestWorldMeshCompleteML: detector with: completionInfo with: future with: completion [

	<apicall: XrResult 'xrRequestWorldMeshCompleteML' (XrWorldMeshDetectorML XrWorldMeshRequestCompletionInfoML* XrFutureEXT XrWorldMeshRequestCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestWorldMeshStateAsyncML: detector with: stateRequest with: future [

	<apicall: XrResult 'xrRequestWorldMeshStateAsyncML' (XrWorldMeshDetectorML XrWorldMeshStateRequestInfoML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRequestWorldMeshStateCompleteML: detector with: future with: completion [

	<apicall: XrResult 'xrRequestWorldMeshStateCompleteML' (XrWorldMeshDetectorML XrFutureEXT XrWorldMeshStateRequestCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrResultToString: instance with: value with: buffer [

	<apicall: XrResult 'xrResultToString' (XrInstance XrResult char[])>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrRetrieveSpaceQueryResultsFB: session with: requestId with: results [

	<apicall: XrResult 'xrRetrieveSpaceQueryResultsFB' (XrSession XrAsyncRequestIdFB XrSpaceQueryResultsFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSaveSpaceFB: session with: info with: requestId [

	<apicall: XrResult 'xrSaveSpaceFB' (XrSession XrSpaceSaveInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSaveSpaceListFB: session with: info with: requestId [

	<apicall: XrResult 'xrSaveSpaceListFB' (XrSession XrSpaceListSaveInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSendVirtualKeyboardInputMETA: keyboard with: info with: interactorRootPose [

	<apicall: XrResult 'xrSendVirtualKeyboardInputMETA' (XrVirtualKeyboardMETA XrVirtualKeyboardInputInfoMETA* XrPosef*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSessionBeginDebugUtilsLabelRegionEXT: session with: labelInfo [

	<apicall: XrResult 'xrSessionBeginDebugUtilsLabelRegionEXT' (XrSession XrDebugUtilsLabelEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSessionEndDebugUtilsLabelRegionEXT: session [

	<apicall: XrResult 'xrSessionEndDebugUtilsLabelRegionEXT' (XrSession)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSessionInsertDebugUtilsLabelEXT: session with: labelInfo [

	<apicall: XrResult 'xrSessionInsertDebugUtilsLabelEXT' (XrSession XrDebugUtilsLabelEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetAndroidApplicationThreadKHR: session with: threadType with: threadId [

	<apicall: XrResult 'xrSetAndroidApplicationThreadKHR' (XrSession XrAndroidThreadTypeKHR uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetColorSpaceFB: session with: colorSpace [

	<apicall: XrResult 'xrSetColorSpaceFB' (XrSession XrColorSpaceFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetDebugUtilsObjectNameEXT: instance with: nameInfo [

	<apicall: XrResult 'xrSetDebugUtilsObjectNameEXT' (XrInstance XrDebugUtilsObjectNameInfoEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetDigitalLensControlALMALENCE: session with: digitalLensControl [

	<apicall: XrResult 'xrSetDigitalLensControlALMALENCE' (XrSession XrDigitalLensControlALMALENCE*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetEnvironmentDepthEstimationVARJO: session with: enabled [

	<apicall: XrResult 'xrSetEnvironmentDepthEstimationVARJO' (XrSession XrBool32)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetEnvironmentDepthHandRemovalMETA: environmentDepthProvider with: setInfo [

	<apicall: XrResult 'xrSetEnvironmentDepthHandRemovalMETA' (XrEnvironmentDepthProviderMETA XrEnvironmentDepthHandRemovalSetInfoMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetInputDeviceActiveEXT: session with: interactionProfile with: topLevelPath with: isActive [

	<apicall: XrResult 'xrSetInputDeviceActiveEXT' (XrSession XrPath XrPath XrBool32)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetInputDeviceLocationEXT: session with: topLevelPath with: inputSourcePath with: space with: pose [

	<apicall: XrResult 'xrSetInputDeviceLocationEXT' (XrSession XrPath XrPath XrSpace XrPosef)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetInputDeviceStateBoolEXT: session with: topLevelPath with: inputSourcePath with: state [

	<apicall: XrResult 'xrSetInputDeviceStateBoolEXT' (XrSession XrPath XrPath XrBool32)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetInputDeviceStateFloatEXT: session with: topLevelPath with: inputSourcePath with: state [

	<apicall: XrResult 'xrSetInputDeviceStateFloatEXT' (XrSession XrPath XrPath float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetInputDeviceStateVector2fEXT: session with: topLevelPath with: inputSourcePath with: state [

	<apicall: XrResult 'xrSetInputDeviceStateVector2fEXT' (XrSession XrPath XrPath XrVector2f)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetMarkerTrackingPredictionVARJO: session with: markerId with: enable [

	<apicall: XrResult 'xrSetMarkerTrackingPredictionVARJO' (XrSession uint64_t XrBool32)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetMarkerTrackingTimeoutVARJO: session with: markerId with: timeout [

	<apicall: XrResult 'xrSetMarkerTrackingTimeoutVARJO' (XrSession uint64_t XrDuration)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetMarkerTrackingVARJO: session with: enabled [

	<apicall: XrResult 'xrSetMarkerTrackingVARJO' (XrSession XrBool32)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetPerformanceMetricsStateMETA: session with: state [

	<apicall: XrResult 'xrSetPerformanceMetricsStateMETA' (XrSession XrPerformanceMetricsStateMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetSpaceComponentStatusFB: space with: info with: requestId [

	<apicall: XrResult 'xrSetSpaceComponentStatusFB' (XrSpace XrSpaceComponentStatusSetInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetSystemNotificationsML: instance with: info [

	<apicall: XrResult 'xrSetSystemNotificationsML' (XrInstance XrSystemNotificationsSetInfoML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetTrackingOptimizationSettingsHintQCOM: session with: domain with: hint [

	<apicall: XrResult 'xrSetTrackingOptimizationSettingsHintQCOM' (XrSession XrTrackingOptimizationSettingsDomainQCOM XrTrackingOptimizationSettingsHintQCOM)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetViewOffsetVARJO: session with: offset [

	<apicall: XrResult 'xrSetViewOffsetVARJO' (XrSession float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSetVirtualKeyboardModelVisibilityMETA: keyboard with: modelVisibility [

	<apicall: XrResult 'xrSetVirtualKeyboardModelVisibilityMETA' (XrVirtualKeyboardMETA XrVirtualKeyboardModelVisibilitySetInfoMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrShareSpacesFB: session with: info with: requestId [

	<apicall: XrResult 'xrShareSpacesFB' (XrSession XrSpaceShareInfoFB* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrShareSpacesMETA: session with: info with: requestId [

	<apicall: XrResult 'xrShareSpacesMETA' (XrSession XrShareSpacesInfoMETA* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSnapshotMarkerDetectorML: markerDetector with: snapshotInfo [

	<apicall: XrResult 'xrSnapshotMarkerDetectorML' (XrMarkerDetectorML XrMarkerDetectorSnapshotInfoML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStartColocationAdvertisementMETA: session with: info with: advertisementRequestId [

	<apicall: XrResult 'xrStartColocationAdvertisementMETA' (XrSession XrColocationAdvertisementStartInfoMETA* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStartColocationDiscoveryMETA: session with: info with: discoveryRequestId [

	<apicall: XrResult 'xrStartColocationDiscoveryMETA' (XrSession XrColocationDiscoveryStartInfoMETA* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStartEnvironmentDepthProviderMETA: environmentDepthProvider [

	<apicall: XrResult 'xrStartEnvironmentDepthProviderMETA' (XrEnvironmentDepthProviderMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStopColocationAdvertisementMETA: session with: info with: requestId [

	<apicall: XrResult 'xrStopColocationAdvertisementMETA' (XrSession XrColocationAdvertisementStopInfoMETA* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStopColocationDiscoveryMETA: session with: info with: requestId [

	<apicall: XrResult 'xrStopColocationDiscoveryMETA' (XrSession XrColocationDiscoveryStopInfoMETA* XrAsyncRequestIdFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStopEnvironmentDepthProviderMETA: environmentDepthProvider [

	<apicall: XrResult 'xrStopEnvironmentDepthProviderMETA' (XrEnvironmentDepthProviderMETA)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStopHapticFeedback: session with: hapticActionInfo [

	<apicall: XrResult 'xrStopHapticFeedback' (XrSession XrHapticActionInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStringToPath: instance with: pathString with: path [

	<apicall: XrResult 'xrStringToPath' (XrInstance char* XrPath*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStructureTypeToString2KHR: instance with: value with: buffer [

	<apicall: XrResult 'xrStructureTypeToString2KHR' (XrInstance XrStructureType char[])>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrStructureTypeToString: instance with: value with: buffer [

	<apicall: XrResult 'xrStructureTypeToString' (XrInstance XrStructureType char[])>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSubmitDebugUtilsMessageEXT: instance with: messageSeverity with: messageTypes with: callbackData [

	<apicall: XrResult 'xrSubmitDebugUtilsMessageEXT' (XrInstance XrDebugUtilsMessageSeverityFlagsEXT XrDebugUtilsMessageTypeFlagsEXT XrDebugUtilsMessengerCallbackDataEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSuggestInteractionProfileBindings: instance with: suggestedBindings [

	<apicall: XrResult 'xrSuggestInteractionProfileBindings' (XrInstance XrInteractionProfileSuggestedBinding*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSuggestVirtualKeyboardLocationMETA: keyboard with: locationInfo [

	<apicall: XrResult 'xrSuggestVirtualKeyboardLocationMETA' (XrVirtualKeyboardMETA XrVirtualKeyboardLocationInfoMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrSyncActions: session with: syncInfo [

	<apicall: XrResult 'xrSyncActions' (XrSession XrActionsSyncInfo*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrThermalGetTemperatureTrendEXT: session with: domain with: notificationLevel with: tempHeadroom with: tempSlope [

	<apicall: XrResult 'xrThermalGetTemperatureTrendEXT' (XrSession XrPerfSettingsDomainEXT XrPerfSettingsNotificationLevelEXT* float* float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshBeginUpdateFB: mesh [

	<apicall: XrResult 'xrTriangleMeshBeginUpdateFB' (XrTriangleMeshFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshBeginVertexBufferUpdateFB: mesh with: outVertexCount [

	<apicall: XrResult 'xrTriangleMeshBeginVertexBufferUpdateFB' (XrTriangleMeshFB uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshEndUpdateFB: mesh with: vertexCount with: triangleCount [

	<apicall: XrResult 'xrTriangleMeshEndUpdateFB' (XrTriangleMeshFB uint32_t uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshEndVertexBufferUpdateFB: mesh [

	<apicall: XrResult 'xrTriangleMeshEndVertexBufferUpdateFB' (XrTriangleMeshFB)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshGetIndexBufferFB: mesh with: outIndexBuffer [

	<apicall: XrResult 'xrTriangleMeshGetIndexBufferFB' (XrTriangleMeshFB uint32_t**)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTriangleMeshGetVertexBufferFB: mesh with: outVertexBuffer [

	<apicall: XrResult 'xrTriangleMeshGetVertexBufferFB' (XrTriangleMeshFB XrVector3f**)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTryCreateSpatialGraphStaticNodeBindingMSFT: session with: createInfo with: nodeBinding [

	<apicall: XrResult 'xrTryCreateSpatialGraphStaticNodeBindingMSFT' (XrSession XrSpatialGraphStaticNodeBindingCreateInfoMSFT* XrSpatialGraphNodeBindingMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrTryGetPerceptionAnchorFromSpatialAnchorMSFT: session with: anchor with: perceptionAnchor [

	<apicall: XrResult 'xrTryGetPerceptionAnchorFromSpatialAnchorMSFT' (XrSession XrSpatialAnchorMSFT IUnknown**)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUnpersistSpatialAnchorMSFT: spatialAnchorStore with: spatialAnchorPersistenceName [

	<apicall: XrResult 'xrUnpersistSpatialAnchorMSFT' (XrSpatialAnchorStoreConnectionMSFT XrSpatialAnchorPersistenceNameMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUpdateHandMeshMSFT: handTracker with: updateInfo with: handMesh [

	<apicall: XrResult 'xrUpdateHandMeshMSFT' (XrHandTrackerEXT XrHandMeshUpdateInfoMSFT* XrHandMeshMSFT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUpdatePassthroughColorLutMETA: colorLut with: updateInfo [

	<apicall: XrResult 'xrUpdatePassthroughColorLutMETA' (XrPassthroughColorLutMETA XrPassthroughColorLutUpdateInfoMETA*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUpdateSpatialAnchorsExpirationAsyncML: storage with: updateInfo with: future [

	<apicall: XrResult 'xrUpdateSpatialAnchorsExpirationAsyncML' (XrSpatialAnchorsStorageML XrSpatialAnchorsUpdateExpirationInfoML* XrFutureEXT*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUpdateSpatialAnchorsExpirationCompleteML: storage with: future with: completion [

	<apicall: XrResult 'xrUpdateSpatialAnchorsExpirationCompleteML' (XrSpatialAnchorsStorageML XrFutureEXT XrSpatialAnchorsUpdateExpirationCompletionML*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrUpdateSwapchainFB: swapchain with: state [

	<apicall: XrResult 'xrUpdateSwapchainFB' (XrSwapchain XrSwapchainStateBaseHeaderFB*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrWaitFrame: session with: frameWaitInfo with: frameState [

	<apicall: XrResult 'xrWaitFrame' (XrSession XrFrameWaitInfo* XrFrameState*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
OXRApi >> xrWaitSwapchainImage: swapchain with: waitInfo [

	<apicall: XrResult 'xrWaitSwapchainImage' (XrSwapchain XrSwapchainImageWaitInfo*)>
	^ self externalCallFailed
]
