Class {
	#name : #SRPlaneTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:38'
}
SRPlaneTest >> testCollisionGeometry [

	"The collider is bounded by scale x and z: a plane lies in its own xz, so scale y
	is thickness and says nothing about its extent."

	| plane geometry |
	plane := SRPlane new
		scale: 4 @ 1 @ 6;
		translation: 1 @ 2 @ 3;
		yourself.
	geometry := plane collisionGeometry.
	self assert: geometry point equals: plane globalTranslation.
	self assert: geometry normal equals: plane normal.
	self assert: geometry up equals: plane planeUp.
	self assert: geometry width equals: 4.0.
	self assert: geometry height equals: 6.0.
	self assert: geometry isBounded.
	self assert: geometry object == plane.
]
