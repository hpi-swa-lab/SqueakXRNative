"
I am a tracer fired by an SRGun. I fly in a straight line with a constant velocity (meters per second) and remove myself after #lifetime milliseconds.
"
Class {
	#name : #SRGunBullet,
	#superclass : #SRObject,
	#instVars : [
		'velocity',
		'age'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGunBullet class >> lifetime [
	"in milliseconds"

	^ 1500
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:41'
}
SRGunBullet class >> streakLength [
	"the streak trails behind the bullet's position"

	^ 80cm
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGunBullet >> initialize [

	super initialize.
	
	age := 0.
	velocity := Vector3 zero.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:41'
}
SRGunBullet >> renderOn: aSRRenderer [

	aSRRenderer
		renderPlainCubeTransformed: self globalTransform
			* (Matrix4x4 withOffset: 0 @ 0 @ (self class streakLength / 2))
			* (Matrix4x4 withScale: 0.6cm @ 0.6cm @ self class streakLength)
		withColor: (Color r: 1.0 g: 0.85 b: 0.4).
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGunBullet >> step: deltaTime [

	age := age + deltaTime.
	age > self class lifetime ifTrue: [^ self remove].
	
	self globalTranslation: self globalTranslation + (velocity * (deltaTime / 1000.0)).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGunBullet >> velocity [

	^ velocity
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGunBullet >> velocity: aVector3 [
	"in meters per second"

	velocity := aVector3
]
