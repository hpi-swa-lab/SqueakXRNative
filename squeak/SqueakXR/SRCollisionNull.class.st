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
