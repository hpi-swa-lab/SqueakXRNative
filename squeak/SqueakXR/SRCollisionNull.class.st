Class {
	#name : #SRCollisionNull,
	#superclass : #SRCollisionGeometry,
	#category : #'SqueakXR-Collisions'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:17'
}
SRCollisionNull >> ifCollisionGeometry: aBlock [
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:39'
}
SRCollisionNull >> intersectsBoxCenter: aCentre halfExtents: aHalfExtents [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:13'
}
SRCollisionNull >> isCollisionNull [

	^ true
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:10'
}
SRCollisionNull >> rayIntersection: aRay [

	^ nil
]
