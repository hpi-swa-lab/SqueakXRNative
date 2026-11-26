"
Renders nothing, for avatars without a view.
"
Class {
	#name : #SRNullRenderer,
	#superclass : #SRRenderer,
	#category : #'SqueakXR-Graphics-Renderer',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> cameraPosition [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> cameraTarget [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> cameraUp [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> clearDepth [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> disableBackfaceCulling [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> disableDepthTest [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> enableBackfaceCulling [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> enableDepthTest [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:14'
}
SRNullRenderer >> environment: aVisualEnvironment lights: aCollection [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> render: aFrame from: anAvatar showingWindow: aBoolean painter: aGizmoPainter [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderCircleCenter: aVector3 radius: aFloat axis: anAxis color: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderCubeWiresTransformed: aMatrix4x4 withColor: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderFastCube: anSRFastCube [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderFloorAt: aVector3 size: aNumber [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderGridAt: aVector3 [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderGridSlices: anInt spacing: aNumber [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderHolodeckGridSize: aNumber [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderLineFrom: aPoint to: anEndPoint color: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderLineFrom: startVector3 to: endVector3 withColor: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderMesh: aMesh transform: aMatrix4x4 material: aMaterial [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderSlabAt: aVector3 size: aNumber thickness: aThickness [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderSphereTransformed: aMatrix4x4 withColor: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderSphereWiresTransformed: aMatrix4x4 withColor: aColor [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> renderWireCubeTransformed: aMatrix4x4 withColor: aColor [

]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> rendersViews [

	^ false
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> withTransform: aMatrix4x4 do: aBlock [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> withoutBackfaceCullingDo: aBlock [

]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRNullRenderer >> withoutDepthTestDo: aBlock [

]
