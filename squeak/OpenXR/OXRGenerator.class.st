Class {
	#name : #OXRGenerator,
	#superclass : #Object,
	#instVars : [
		'registry',
		'bitmaskTypes',
		'externalTypes',
		'defines',
		'structCount'
	],
	#category : #'OpenXR-Core'
}

{ #category : #'as yet unclassified' }
OXRGenerator class >> categoryName: aString [

	^ 'OpenXR-', aString, '-Generated'
]

{ #category : #'as yet unclassified' }
OXRGenerator class >> fromFile: aFile [

	UIManager default informUser: 'Generating OpenXR API from ', aFile name during: [
		UIManager default informUser: 'Cleaning...' during: [
			self removeGeneratedCategories].
		^ self new initializeWithXML: (XMLDOMParser parseDocumentFrom: aFile fullName asURI contentStream)]
]

{ #category : #'as yet unclassified' }
OXRGenerator class >> matchAllCategory [

	^ self categoryName: '*'
]

{ #category : #'as yet unclassified' }
OXRGenerator class >> removeGeneratedCategories [

	Smalltalk environment organization removeCategoriesMatching: self matchAllCategory
]

{ #category : #'as yet unclassified' }
OXRGenerator class >> structCategoryMaxSize [

	^ 100
]

{ #category : #'as yet unclassified' }
OXRGenerator >> collectDefines [

	registry tagsNamed: #types do: [:types |
		types tagsNamed: #type do: [:type |
			
			(type attributeAt: #category) = #define ifTrue: [
				defines
					at: (type elementAt: 'name') contentString
					put: type elementsAndContents last string withBlanksTrimmed]]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> commandDefinitionFor: aString [

	registry tagsNamed: #command do: [:command |
		(command attributeAt: #name) = aString ifTrue: [^ command]].
	^ self error: 'method definition not found'
]

{ #category : #'as yet unclassified' }
OXRGenerator >> compileExtraMethods [

	XrQuaternionf compile: 'a ^ self w'.
	XrQuaternionf compile: 'b ^ self x'.
	XrQuaternionf compile: 'c ^ self y'.
	XrQuaternionf compile: 'd ^ self z'.
	XrQuaternionf compile: 'squaredLength ^ self w squared + self x squared + self y squared + self z squared'
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createCommandAlias: commandTag [

	^ self getAPIClass compile: (String streamContents: [:stream | | params |
		params := Array streamContents: [:strList |
			(self commandDefinitionFor: (commandTag attributeAt: #alias)) tagsNamed: #params childrenDo: [:child | strList nextPut: child]].
		stream
			nextPutAll: (self signatureStringFor: (commandTag attributeAt: #name) params: #());
			crtab;
			nextPutAll: '^ self ';
			nextPutAll: (self signatureStringFor: (commandTag attributeAt: #alias) params: #())])
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createCommandMethod: commandTag [

	| protoTag params string |
	
	(commandTag attributeAt: #alias) ifNotNil: [^ self createCommandAlias: commandTag].
	
	protoTag := commandTag firstTagNamed: #proto.
	params := Array streamContents: [:stream |
		commandTag tagsNamed: #param childrenDo: [:param | stream nextPut: param]].
	
	^ self getAPIClass compile: (String streamContents: [:stream | | name |
		name := (protoTag firstTagNamed: #name) contentString.
		stream nextPutAll: (self signatureStringFor: name params: params).
		
		stream
			cr;
			crtab;
			nextPutAll: '<apicall: ';
			nextPutAll: (self paramType: protoTag);
			nextPutAll: ' ''';
			nextPutAll: name;
			nextPutAll: ''' ('.
		params do: [:param | stream nextPutAll: (self paramType: param)] separatedBy: [stream space].
		stream
			nextPutAll: ')>';
			cr;
			tab;
			nextPutAll: '^ self externalCallFailed'])
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createCommands [

	registry
		tagsNamed: #commands
		do: [:commands |
			commands tagsNamed: #command do: [:command | self createCommandMethod: command]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createEnums [

	registry tagsNamed: #enums do: [:enums | | class |
		class := bitmaskTypes
			at: (enums attributeAt: #name)
			ifAbsent: [self createTypedef: (self enumNameFor: (enums attributeAt: #name)) type: 'long'].
		enums tagsNamed: #enum do: [:enum |
			class class compile: (String streamContents: [:stream |
				stream
					nextPutAll: (enum attributeAt: #name);
					cr;
					cr;
					tab;
					nextPutAll: '^ self on: ('.
				self printValueOf: enum on: stream.
				stream nextPut: $)]).
			defines at: (enum attributeAt: #name) put: (enum attributeAt: #value)]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createExtension: aString [

	registry
		tagsNamed: #extension
		do: [:extension |
			(extension attributeAt: #name) = aString ifTrue: [self createExtensionFrom: extension. ^ self]].
	self assert: false description: 'extension not found'
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createExtensionFrom: aTag [

	aTag tagsNamed: #enum do: [:enum | | value |
		(enum attributeAt: #extends)
			ifNotNil: [ | className |
				value := (enum attributeAt: #offset)
					ifNotNil: [:offset | | extBase extBlockSize extnumber |
						extBase := 1000000000.
						extBlockSize := 1000.
						extnumber := enum attributeAt: #extnumber ifAbsent: [(aTag attributeAt: #number) asInteger].
						extBase + (extnumber - 1 * extBlockSize + offset) * ((enum attributeAt: #dir) ifNotNil: [-1] ifNil: [1])]
					ifNil: [enum attributeAt: #value].
				
				className := (enum attributeAt: #extends) asSymbol.
				(Smalltalk at: (bitmaskTypes at: className ifPresent: #name ifAbsent: [className])) class compile: (String streamContents: [:stream |
					stream
						nextPutAll: (enum attributeAt: #name);
						cr;
						cr;
						tab;
						nextPutAll: '^ self on: (';
						nextPutAll: value asString;
						nextPut: $)])]
			ifNil: [
				OXRConstants class compile: (String streamContents: [:stream |
					stream
						nextPutAll: (enum attributeAt: #name);
						cr;
						cr;
						tab;
						nextPutAll: '^ self on: ('.
					self printValueOf: enum on: stream.
					stream nextPut: $)]).
				defines at: (enum attributeAt: #name) put: (enum attributeAt: #value)]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createExtensions [

	registry tagsNamed: #extension do: [:ext | self createExtensionFrom: ext]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createExternalStructure: aClass from: type [

	| class |
	self assert: ((type attributeAt: #name) occurrencesOf: Character space) = 0.
	class := aClass
		subclass: (type attributeAt: #name) asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: (self class categoryName: 'Structs-', self structCategoryIndex asString).
	self incrementStructCount.
	class class compile: (String streamContents: [:stream |
		stream
			nextPutAll: 'fields';
			cr;
			cr;
			tab;
			nextPutAll: '^ #(';
			crtab.
		type
			tagsNamed: #member
			do: [:member |
				self assert: (member elementAt: #name) contents size = 1.
				self assert: (member elementAt: #type) contents size = 1.
				
				stream
					tab;
					nextPut: $(;
					nextPutAll: (member elementAt: #name) contentString;
					space;
					nextPut: $';
					nextPutAll: (self typeNameFrom: member);
					nextPut: $';
					nextPut: $);
					crtab].
		stream nextPutAll: ')'])
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createStruct: aType [

	self createExternalStructure: ExternalStructure from: aType
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createTypeFor: type [

	(type attributeAt: #category) = #handle ifTrue: [
		^ self createTypedef: type type: 'intptr_t'].
	
	(type attributeAt: #category) = #bitmask ifTrue: [ | class |
		^ (type attributeAt: #alias)
			ifNotNil: [:alias |
				self
					createTypedef: type
					type: alias]
			ifNil: [
				class := self createTypedef: type type: 'long'.
				(type attributeAt: #requires) ifNotNil: [:req | bitmaskTypes at: req put: class]]].
	
	(type attributeAt: #category) = #funcpointer ifTrue: [^ self createTypedef: type type: 'void*'].
	
	((type attributeAt: #category) = #enum and: [(type attributeAt: #alias) notNil]) ifTrue: [
		^ self
			createTypedef: type
			type: (self typeName: (type attributeAt: #alias))].
	
	(type attributeAt: #category) = #basetype ifTrue: [
		(type contentString beginsWith: 'typedef') ifTrue: [^ self createTypedef: type].
		(type contentString beginsWith: 'struct') ifTrue: [^ externalTypes add: (type elementAt: #name) contentString].
		(type elementAt: 'type') ifNotNil: [:t |
			(t contentString = 'XR_DEFINE_ATOM' or: [t contentString = 'XR_DEFINE_OPAQUE_64']) ifTrue: [
				^ self
					createTypedef: type
					type: 'uint64_t']]].
	
	(type attributeAt: #category) = #struct ifTrue: [^ self createStruct: type].
	
	(type attributeAt: #category) = #union ifTrue: [^ self createUnion: type].
	
	(type attributeAt: #requires) ifNotNil: [:req |
		^ req ~= 'vk_platform' ifTrue: [externalTypes add: (type attributeAt: #name)]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createTypedef: aType [

	self createTypedef: aType type: (aType elementAt: #type) contentString
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createTypedef: aType type: aString [

	| class name |
	name := aType isString ifTrue: [aType] ifFalse: [(aType elementAt: #name) ifNotNil: #contentString ifNil: [aType attributeAt: #name]].
	self assert: name notNil.
	
	class := ExternalTypeAlias
		subclass: name asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: (self class categoryName: 'Typedefs').
	class class compile: 'originalTypeName

    ^ ''', (aString, '''').

	class defineFields.
	^ class
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createTypes [

	registry tagsNamed: #types do: [:types |
		types tagsNamed: #type do: [:type | self createTypeFor: type]]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> createUnion: type [

	self createExternalStructure: ExternalUnion from: type
]

{ #category : #'as yet unclassified' }
OXRGenerator >> enumNameFor: name [

	name = 'API Constants' ifTrue: [^ 'OXRConstants'].
	^ name
]

{ #category : #'as yet unclassified' }
OXRGenerator >> formatNumber: aString [

	| string |
	aString first = $" ifTrue: [^ aString copyReplaceAll: '"' with: ''''].
	string := aString.
	#('~0ULL' '~0U')
		with: #(18446744073709551615 4294967295)
		do: [:symbol :value | string := string copyReplaceAll: symbol with: '16r', (value printStringBase: 16)].
	^ string
]

{ #category : #'as yet unclassified' }
OXRGenerator >> getAPIClass [

	^ Smalltalk
		at: #OXRApi
		ifAbsent: [ | lib |
			lib := ExternalLibrary
				subclass: #OXRApi
				instanceVariableNames: ''
				classVariableNames: ''
				poolDictionaries: ''
				category: (self class categoryName: 'Classes').
			lib class compile: 'moduleName

	^ ''libvulkan'''.
			lib]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> includesNativeType: aString [

	(aString beginsWith: 'xcb_') ifTrue: [^ true].
	(aString beginsWith: 'wl_') ifTrue: [^ true].
	(aString beginsWith: 'ID3D') ifTrue: [^ true].
	(aString beginsWith: 'EGL') ifTrue: [^ true].
	(aString beginsWith: 'Vk') ifTrue: [^ true].
	^ false
]

{ #category : #'as yet unclassified' }
OXRGenerator >> incrementStructCount [

	structCount := structCount + 1
]

{ #category : #'as yet unclassified' }
OXRGenerator >> initializeWithXML: anXML [

	defines := Dictionary new.
	registry := anXML firstTagNamed: #registry.
	
	bitmaskTypes := Dictionary new.
	
	externalTypes := OrderedCollection new.
	
	structCount := 0.
	
	"SystemChangeNotifier uniqueInstance doSilently:" [
		#(collectDefines createEnums createExtensions createTypes createCommands)
			do: [:selector | self perform: selector]
			displayingProgress: [:selector | selector]] value.
	
	self compileExtraMethods
]

{ #category : #'as yet unclassified' }
OXRGenerator >> paramType: anElement [

	| result |
	result := String streamContents: [:stream |
		anElement elementsAndContentsDo: [:part |
			part isText
				ifTrue: [stream nextPutAll: part string]
				ifFalse: [
					part tag = #type ifTrue: [stream nextPutAll: part contentString]]]].
	^ ((result copyReplaceAll: 'const' with: '') copyReplaceAll: ' ' with: '') copyWithRegex: '\[.+\]' matchesReplacedWith: '*'
]

{ #category : #'as yet unclassified' }
OXRGenerator >> patchCAMetalLayer [

	| class |
	class := ExternalTypeAlias
		subclass: #CAMetalLayer
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: (self categoryName: 'Classes').
	class compile: 'originalTypeName

    ^ ''void*'''
]

{ #category : #'as yet unclassified' }
OXRGenerator >> printValueOf: enum on: stream [

	(enum attributeAt: #alias) ifNotNil: [:alias |
		^ stream
			nextPutAll: 'self ';
			nextPutAll: alias].
	(enum attributeAt: #bitpos) ifNotNil: [:position |
		^ stream
			nextPutAll: '1 bitShift: ';
			nextPutAll: position].
	self assert: (enum attributeAt: #value) notNil.
	stream nextPutAll: (self formatNumber: (enum attributeAt: #value))
]

{ #category : #'as yet unclassified' }
OXRGenerator >> runCommand: aString stdin: anotherString [

	| proc d in input |
	in := OSPipe blockingPipe.
	input := in reader.
	
	d := Delay forMilliseconds: 50.
	proc := UnixProcess
		forkJob: ExternalUnixOSProcess defaultShellPath
		arguments: (Array with: '-c' with: aString)
		environment: nil
		descriptors: (Array with: input with: nil with: nil).
	input close.
	in writer nextPutAll: anotherString; close.
	
	proc ifNil: [self class noAccessorAvailable].
	[proc runState == #complete] whileFalse: [d wait].
	^ proc exitStatus
]

{ #category : #'as yet unclassified' }
OXRGenerator >> signatureStringFor: aString params: aCollection [

	^ String streamContents: [:stream |
		stream nextPutAll: aString.
		aCollection ifNotEmpty: [stream nextPutAll: ': '].
		aCollection
			do: [:param |
				stream nextPutAll: (param firstTagNamed: #name) contentString]
			separatedBy: [stream nextPutAll: ' with: ']]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> structCategoryIndex [

	^ structCount // self class structCategoryMaxSize + 1
]

{ #category : #'as yet unclassified' }
OXRGenerator >> testCommand: aString [

	| proc d |
	d := Delay forMilliseconds: 50.
	proc := OSProcess thisOSProcess
		forkJob: aString
		arguments: nil
		environment: nil
		descriptors: nil.
	proc ifNil: [self class noAccessorAvailable].
	[proc runState == #complete] whileFalse: [d wait].
self halt.
	^ proc exitStatus
]

{ #category : #'as yet unclassified' }
OXRGenerator >> typeName: aString [

	| typeName |
	typeName := aString.
	bitmaskTypes at: typeName ifPresent: [:actualType |
		typeName := actualType name].
	((externalTypes includes: typeName) and: [typeName first isUppercase]) ifTrue: [typeName := 'void'].
	^ typeName
]

{ #category : #'as yet unclassified' }
OXRGenerator >> typeName: aString from: member [

	| typeName |
	typeName := aString.
	bitmaskTypes at: typeName ifPresent: [:actualType |
		typeName := actualType name].
	(externalTypes includes: typeName) ifTrue: [
		self halt.
		typeName := 'void'].
	(member notNil and: [member contents anySatisfy: [:t | t string includes: $*]]) ifTrue: [typeName := typeName, '*'].
	(member notNil and: [member contents anySatisfy: [:t | t string includes: $[]]) ifTrue: [self halt].
	^ typeName
]

{ #category : #'as yet unclassified' }
OXRGenerator >> typeNameFrom: member [

	| type |
	type := (((String streamContents: [:stream |
		member elementsAndContentsDo: [:el |
			el isText
				ifTrue: [ | str |
					str := (el string copyReplaceAll: 'const' with: '') copyReplaceAll: 'struct' with: ''.
					defines keysAndValuesDo: [:key :value | str := str copyReplaceAll: key with: value].
					stream nextPutAll: str]
				ifFalse: [
					el tag caseOf: {
						[#type] -> [stream nextPutAll: (self typeName: el contentString)].
						[#enum] -> [stream print: ((Smalltalk at: #OXRConstants) perform: el contentString asSymbol) value].
						[#comment] -> [].
						[#name] -> []}]]])
		copyReplaceAll: ' '
		with: '')
		copyReplaceAll: '**'
		with: '*')
		copyWithRegex: '\:\d+'
		matchesReplacedWith: ''.
	(self includesNativeType: type) ifTrue: [^ 'void*'].
	^ type
	" some structs define bitfield sizes, which are potentially ignored anyways in the C impl? "
]

{ #category : #'as yet unclassified' }
OXRGenerator >> verifyStructSize: aClass [

	| actualSize generatedSize |
	(aClass fields notEmpty and: [(self runCommand: 'gcc -x c - -o vktestsize' stdin: '#include <vulkan/vulkan.h>
#include <stdio.h>
int main() { printf("%li", sizeof(', aClass name, ')); return 0; }') = 0]) ifTrue: [
		actualSize := (OSProcess thisOSProcess waitForCommandOutput: './vktestsize') asInteger.
		generatedSize := aClass externalType byteSize.
		self assert: actualSize = generatedSize]
]

{ #category : #'as yet unclassified' }
OXRGenerator >> verifyStructSizes [

	(ExternalStructure allSubclasses select: [:class | self class matchAllCategory match: class category])
		do: [:class | self verifyStructSize: class] displayingProgress: 'Verifying Struct Sizes'
]
