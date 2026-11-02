"
Tests for SRGunMuzzleFlash.
"
Class {
	#name : #SRGunMuzzleFlashTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:38'
}
SRGunMuzzleFlashTest >> testLightFadesWithTheFlash [

	| flash |
	flash := SRGunMuzzleFlash new.
	flash flash.
	flash step: SRGunMuzzleFlash duration / 2.
	
	self assert: 1 / 2 equals: flash light intensity.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:38'
}
SRGunMuzzleFlashTest >> testLightShinesOnlyWhileFlashing [

	| flash |
	flash := SRGunMuzzleFlash new.
	self deny: flash light isShining.
	
	flash flash.
	self assert: flash light isShining.
	
	flash step: SRGunMuzzleFlash duration.
	self deny: flash light isShining.
]
