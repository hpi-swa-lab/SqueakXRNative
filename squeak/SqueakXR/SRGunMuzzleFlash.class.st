"
I am the short-lived muzzle flash of an SRGun: a hot core, an orange plume and a star of spikes, randomly rotated and sized on every shot. I am invisible until #flash is sent and fade out over #duration milliseconds.
"
Class {
	#name : #SRGunMuzzleFlash,
	#superclass : #SRObject,
	#instVars : [
		'timeRemaining',
		'spin',
		'size'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash class >> duration [
	"in milliseconds"

	^ 60
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash >> flash [

	timeRemaining := self class duration.
	spin := 90 atRandom.
	size := 0.8 + (0.4 * ThreadSafeRandom value next).
	self visible: true.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash >> initialize [

	super initialize.
	
	timeRemaining := 0.
	spin := 0.
	size := 1.
	self visible: false.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash >> partAt: aVector3 rotation: degreesAroundForward scale: scaleVector3 [

	^ self globalTransform
		* (Matrix4x4 withOffset: aVector3)
		* (Matrix4x4 withRotation: degreesAroundForward around: Vector3 forward)
		* (Matrix4x4 withScale: scaleVector3)
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash >> renderOn: aSRRenderer [

	| fade s |
	timeRemaining <= 0 ifTrue: [^ self].
	
	"the flash is biggest right after the shot and shrinks while it fades"
	fade := timeRemaining / self class duration.
	s := size * (0.5 + (0.5 * fade)).
	
	aSRRenderer
		renderSphereTransformed: (self partAt: 0 @ 0 @ (-5cm * s) rotation: spin scale: (5cm * s) @ (5cm * s) @ (12cm * s))
		withColor: (Color r: 1.0 g: 0.45 b: 0.05).
	aSRRenderer
		renderSphereTransformed: (self partAt: 0 @ 0 @ (-1.5cm * s) rotation: spin scale: (3.2cm * s) asVector3)
		withColor: (Color r: 1.0 g: 0.95 b: 0.6).
	
	0 to: 270 by: 90 do: [:angle |
		aSRRenderer
			renderPlainCubeTransformed: ((self partAt: 0 @ 0 @ (-1cm * s) rotation: spin + angle scale: 1 asVector3)
				* (Matrix4x4 withOffset: 0 @ (3.5cm * s) @ 0)
				* (Matrix4x4 withScale: (0.8cm * s) @ (6cm * s) @ (0.8cm * s)))
			withColor: (Color r: 1.0 g: 0.8 b: 0.2)].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:36'
}
SRGunMuzzleFlash >> step: deltaTime [

	timeRemaining <= 0 ifTrue: [^ self].
	
	timeRemaining := timeRemaining - deltaTime.
	timeRemaining <= 0 ifTrue: [
		timeRemaining := 0.
		self visible: false].
]
