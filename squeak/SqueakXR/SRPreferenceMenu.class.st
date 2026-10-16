"
Puts Squeak preferences in the XR world menu, one row per preference, so a setting declared with a <preference:> pragma anywhere needs no menu code of its own.

Booleans toggle when picked. Numbers only show their value: editing one needs a number entry that does not exist in XR yet.
"
Class {
	#name : #SRPreferenceMenu,
	#superclass : #Object,
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRPreferenceMenu class >> activate: aPreference [
	"Symbol-valued preferences cycle through their choices; a number waits for
	an editor."

	| value |
	value := aPreference preferenceValue.
	(value == true or: [value == false])
		ifTrue: [^ aPreference preferenceValue: value not].
	^ self cycle: aPreference
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:18'
}
SRPreferenceMenu class >> choicesFor: aPreference [
	"Choices live next to the preference: whoever declares #turnStyle declares
	#turnStyleChoices. Squeak's preference types have no notion of a choice."

	| selector provider |
	(aPreference respondsTo: #selectors) ifFalse: [^ nil].
	provider := aPreference provider.
	"#selectors answers the getter and the setter; PragmaPreference keeps the
	getter in an instance variable with no accessor."
	selector := (aPreference selectors first , 'Choices') asSymbol.
	^ (provider respondsTo: selector)
		ifTrue: [provider perform: selector]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRPreferenceMenu class >> cycle: aPreference [
	"A value that is not in the list, or a preference with no list at all, lands
	on the first choice rather than doing nothing."

	| choices index |
	choices := self choicesFor: aPreference.
	(choices isNil or: [choices isEmpty]) ifTrue: [^ self].
	index := choices indexOf: aPreference preferenceValue.
	aPreference preferenceValue: (choices at: index \\ choices size + 1)
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:15'
}
SRPreferenceMenu class >> entryFor: aPreference under: aCategory [
	"The row keeps the menu open whether or not it does anything: a number row
	that closed the menu on every misdirected ray would be worse than useless."

	^ SRMenuEntry new
		setPath: (Array with: #world with: #preferences with: aCategory)
		label: [self labelFor: aPreference]
		priority: 500
		provider: self
		action: [self activate: aPreference];
		keepOpen: true;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:15'
}
SRPreferenceMenu class >> exposedCategories [
	"Named, not discovered: Squeak has hundreds of preference categories and
	almost none of them mean anything inside a headset."

	^ #(#SqueakXR #SWAGame)
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRPreferenceMenu class >> labelFor: aPreference [
	^ String streamContents: [:s |
		s nextPutAll: aPreference name; nextPutAll: ': '.
		self printValueOf: aPreference on: s]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:15'
}
SRPreferenceMenu class >> menuEntries [
	<xrMenuEntries>
	| entries |
	entries := OrderedCollection new.
	self exposedCategories do: [:category |
		((Preferences preferencesInCategory: category)
			asSortedCollection: [:a :b | a name <= b name]) do: [:pref |
				entries add: (self entryFor: pref under: category)]].
	^ entries
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRPreferenceMenu class >> printValueOf: aPreference on: aStream [
	| value |
	value := aPreference preferenceValue.
	value == true ifTrue: [^ aStream nextPutAll: 'ON'].
	value == false ifTrue: [^ aStream nextPutAll: 'off'].
	value isNumber ifTrue: [^ aStream nextPutAll: value printString].
	aStream nextPutAll: value asString
]
