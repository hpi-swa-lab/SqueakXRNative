"
Exercises the preference rows against the real SqueakXR preferences rather than a fixture, so a preference that stops being reachable from the menu fails here. setUp saves the ones it touches: running the tests must never retune the live world.
"
Class {
	#name : #SRPreferenceMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'savedTurnStyle',
		'savedLocomotionStyle'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRPreferenceMenuTest >> rowNamed: aString [
	^ (SRMenuRegistry current directItemsUnder: #(world preferences SqueakXR))
		detect: [:each | (each labelIn: nil target: nil) beginsWith: aString]
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:43'
}
SRPreferenceMenuTest >> setUp [
	super setUp.
	"The class variable, not the getter: nil is the documented 'use the code
	default' value, and writing the resolved value back would quietly pin it."
	savedTurnStyle := SRAvatar classPool at: #SmoothTurn.
	savedLocomotionStyle := SRAvatar classPool at: #ContinuousLocomotion.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:43'
}
SRPreferenceMenuTest >> tearDown [
	SRAvatar classPool at: #SmoothTurn put: savedTurnStyle.
	SRAvatar classPool at: #ContinuousLocomotion put: savedLocomotionStyle.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:20'
}
SRPreferenceMenuTest >> testBooleanPreferenceTogglesAndTheLabelFollows [
	| pref row before |
	pref := (Preferences preferencesInCategory: #SqueakXR)
		detect: [:each | each preferenceValue == true or: [each preferenceValue == false]].
	row := (SRMenuRegistry current directItemsUnder: #(world preferences SqueakXR))
		detect: [:each | (each labelIn: nil target: nil) beginsWith: pref name].
	before := pref preferenceValue.
	[row activateIn: nil target: nil.
	self assert: pref preferenceValue = before not.
	self assert: ((row labelIn: nil target: nil) endsWith: (before ifTrue: ['off'] ifFalse: ['ON']))]
		ensure: [pref preferenceValue: before].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRPreferenceMenuTest >> testEveryExposedCategoryIsAGroup [
	| groups |
	groups := SRMenuRegistry current groupsUnder: #(world preferences).
	SRPreferenceMenu exposedCategories do: [:category |
		self assert: (groups includes: category)].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:20'
}
SRPreferenceMenuTest >> testNumberRowShowsItsValueAndDoesNotChangeIt [
	"Numbers wait for an editor. Until then a picked row must be inert rather
	than cycling to something arbitrary."

	| row |
	row := self rowNamed: 'Snap turn angle'.
	self assert: (row labelIn: nil target: nil) = ('Snap turn angle: ' , SRAvatar snapTurnAngle printString).
	row activateIn: nil target: nil.
	self assert: (row labelIn: nil target: nil) = ('Snap turn angle: ' , SRAvatar snapTurnAngle printString).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:20'
}
SRPreferenceMenuTest >> testPreferenceRowsKeepTheMenuOpen [
	"A settings menu that shuts on every pick cannot be used to try a setting."

	(SRMenuRegistry current itemsUnder: #(world preferences)) do: [:each |
		self assert: each keepOpen].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:43'
}
SRPreferenceMenuTest >> testTheStyleSymbolsFollowTheirBooleanPreferences [
	"The styles are symbols everywhere inside, but declared as Boolean
	preferences: Squeak's Preference Browser has no view for #Symbol and one
	unsupported type takes the whole browser down."

	SRAvatar smoothTurn: false.
	self assert: #snap equals: SRAvatar turnStyle.
	SRAvatar smoothTurn: true.
	self assert: #smooth equals: SRAvatar turnStyle.
	SRAvatar continuousLocomotion: false.
	self assert: #teleport equals: SRAvatar locomotionStyle.
	SRAvatar continuousLocomotion: true.
	self assert: #continuous equals: SRAvatar locomotionStyle.
	"The symbol setters still work, because everything inside speaks symbols."
	SRAvatar turnStyle: #snap.
	self deny: SRAvatar smoothTurn.
]
