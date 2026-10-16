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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRPreferenceMenuTest >> setUp [
	super setUp.
	savedTurnStyle := SRAvatar turnStyle.
	savedLocomotionStyle := SRAvatar locomotionStyle.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRPreferenceMenuTest >> tearDown [
	SRAvatar turnStyle: savedTurnStyle.
	SRAvatar locomotionStyle: savedLocomotionStyle.
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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:20'
}
SRPreferenceMenuTest >> testSymbolPreferenceCyclesThroughItsChoices [
	"Squeak's preference types have no notion of a choice, so the row finds the
	list next to the preference. Losing that lookup leaves a dead row that still
	renders."

	| row seen |
	SRAvatar turnStyle: #snap.
	row := self rowNamed: 'Turn style'.
	seen := OrderedCollection new.
	SRAvatar turnStyleChoices size timesRepeat: [
		seen add: SRAvatar turnStyle.
		row activateIn: nil target: nil].
	self assert: seen asArray = SRAvatar turnStyleChoices.
	"A full cycle comes back to where it started."
	self assert: (row labelIn: nil target: nil) = 'Turn style: snap'.
]
