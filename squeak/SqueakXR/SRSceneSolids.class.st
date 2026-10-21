"
Every collision geometry in a scene, collected once so a walk sweep can query it many times in one frame.

It answers #solidInBoxCenter:halfExtents: exactly as an SRObject does, and is passed wherever one would be. The reason it exists is cost: the graph walk plus building one geometry object per collider measures 1.7 ms on a 234-object world, and resolving a step takes a dozen queries per frame.

A snapshot holds global positions, so it is valid for one frame only.
"
Class {
	#name : #SRSceneSolids,
	#superclass : #Object,
	#instVars : [
		'geometries'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRSceneSolids class >> forObject: anSRObject [

	| collected |
	collected := OrderedCollection new.
	anSRObject sceneRoot allDo: [:each |
		(each isSolid and: [(each isWithin: anSRObject) not]) ifTrue: [
			each safeCollisionGeometry ifNotNil: [:geometry |
				collected add: geometry]]].
	^ self new setGeometries: collected asArray
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:28'
}
SRSceneSolids >> setGeometries: aCollection [

	geometries := aCollection.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:28'
}
SRSceneSolids >> size [

	^ geometries size
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:28'
}
SRSceneSolids >> solidInBoxCenter: aCentre halfExtents: aHalfExtents [

	geometries do: [:each |
		(each intersectsBoxCenter: aCentre halfExtents: aHalfExtents)
			ifTrue: [^ true]].
	^ false
]
