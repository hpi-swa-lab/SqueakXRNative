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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRPreferenceMenu class >> activate: aPreference [

	| value |
	value := aPreference preferenceValue.
	(value == true or: [value == false])
		ifTrue: [^ aPreference preferenceValue: value not].
	^ self cycle: aPreference
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRPreferenceMenu class >> choicesFor: aPreference [

	| selector provider |
	(aPreference respondsTo: #selectors) ifFalse: [^ nil].
	provider := aPreference provider.

	selector := (aPreference selectors first , 'Choices') asSymbol.
	^ (provider respondsTo: selector)
		ifTrue: [provider perform: selector]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRPreferenceMenu class >> cycle: aPreference [

	| choices index |
	choices := self choicesFor: aPreference.
	(choices isNil or: [choices isEmpty]) ifTrue: [^ self].
	index := choices indexOf: aPreference preferenceValue.
	aPreference preferenceValue: (choices at: index \\ choices size + 1)
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRPreferenceMenu class >> entryFor: aPreference under: aCategory [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRPreferenceMenu class >> exposedCategories [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:06'
}
SRPreferenceMenu class >> menuEntries [
	<xrMenuEntries>
	| entries |
	entries := OrderedCollection new.
	self exposedCategories do: [:eachCategory |
		((Preferences preferencesInCategory: eachCategory)
			asSortedCollection: [:a :b | a name <= b name]) do: [:pref |
				entries add: (self entryFor: pref under: eachCategory)]].
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
