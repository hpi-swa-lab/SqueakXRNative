Extension { #name : #Object }

{ #category : #'*SqueakXR-helpers' }
Object >> asRaylibObject [

	self error: 'asRaylibObject is not implemented for ', self class name
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 4/2/2026 16:41'
}
Object >> currentXRWorld [

	^ SRWorld current
]

{
	#category : #'*SqueakXR-Collisions',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isCollisionBox [
	^ false.
]

{
	#category : #'*SqueakXR-Collisions',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isCollisionPlane [
	^ false.
]

{
	#category : #'*SqueakXR-Objects',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isCube [
	^ false.
]

{
	#category : #'*SqueakXR-Objects',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isDebugHUD [
	^ false.
]

{
	#category : #'*SqueakXR-Objects',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isGizmoPainter [
	^ false.
]

{
	#category : #'*SqueakXR-Objects',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isMenu [
	^ false.
]

{
	#category : #'*SqueakXR-Objects',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:36'
}
Object >> isMenuItem [
	^ false.
]

{ #category : #'*SqueakXR-core' }
Object >> isWorldObject [

	^ false
]
