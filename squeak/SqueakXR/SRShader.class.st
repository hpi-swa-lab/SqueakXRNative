Class {
	#name : #SRShader,
	#superclass : #Object,
	#instVars : [
		'source',
		'transpiledSource',
		'source330',
		'source300es',
		'vertexSource',
		'fragmentSource',
		'id',
		'internalShader',
		'uniforms',
		'uniformLocs'
	],
	#classVars : [
		'Default',
		'ShaderCache'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #prerequisites,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRShader class >> canTranspile [

	^ (self doesCommandExist: 'glslang')
		and: [self doesCommandExist: 'spirv-cross']
]

{
	#category : #prerequisites,
	#'squeak_changestamp' : 'lege 5/6/2026 13:09'
}
SRShader class >> doesCommandExist: aString [

	^ (ShellSyntax new
		programNameAndArgumentsFrom: aString
		inDirectoryPath: OSProcess thisOSProcess path
		findExecutable: true) notNil
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/15/2026 16:22'
}
SRShader class >> doesNotUnderstand: aMessage [

	^ (self sourceFor: aMessage selector version: self currentXRWorld renderer shaderVersion)
		ifNotNil: [:source | self shaderFromDict: source]
		ifNil: [super doesNotUnderstand: aMessage]
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'jl 8/11/2026 15:52'
}
SRShader class >> duplicateShaderNames [

	| names |
	names := self shaderNames.
	^ (names asSet select: [:each | (names occurrencesOf: each) > 1])
		asSortedCollection asArray
]

{
	#category : #prerequisites,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:09'
}
SRShader class >> ensureGlslangAvailable [

	self assert: (self doesCommandExist: 'glslang')
		description: 'command glslang is missing'
]

{
	#category : #prerequisites,
	#'squeak_changestamp' : 'lege 5/6/2026 13:21'
}
SRShader class >> ensureSpirvCrossAvailable [

	self assert: (self doesCommandExist: 'spirv-cross')
		description: 'command spirv-cross is missing'
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/27/2026 14:09'
}
SRShader class >> evaluateCommand: aCommandString [

	|pipeline out err|
	pipeline := OSProcess evaluate: aCommandString.
	pipeline waitForAllToComplete.
	out := pipeline upToEndOfFile.
	err := pipeline errorUpToEndOfFile.
	
	pipeline succeeded not ifTrue: [
		Transcript
			showln: ('An error occurred while evaluting ''{1}''' format: {aCommandString});
			showln: 'stdout:';
			showln: out;
			showln: 'stderr:';
			showln: err.
		self error: ('An error occurred while evaluating ''{1}''. See Transcript for details.'
			format: {aCommandString})].
	
	^ out
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRShader class >> hasCachedShader: aName [

	^ ShaderCache notNil and: [ShaderCache includesKey: aName asString]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 3/10/2026 11:53'
}
SRShader class >> resetCache [

	ShaderCache := Dictionary new.
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 4/2/2026 17:56'
}
SRShader class >> shaderFromDict: aDictionary [

	^ self new
		vertexSource: (aDictionary at: #vert);
		fragmentSource: (aDictionary at: #frag);
		uniforms: (aDictionary at: #uniforms ifAbsent: [#()])
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRShader class >> shaderNames [
	^ (self shaderSourcePragmas collect: [:p | p arguments first asString]) asArray
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRShader class >> shaderSourcePragmaKeyword [
	^ #shaderSource:
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRShader class >> shaderSourcePragmas [
	| keyword found |
	keyword := self shaderSourcePragmaKeyword.
	found := OrderedCollection new.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:method |
			method pragmasDo: [:pragma |
				pragma keyword = keyword ifTrue: [found add: pragma]]]].
	^ found asArray sort: [:a :b |
		a arguments first asString <= b arguments first asString]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 7/29/2026 12:42'
}
SRShader class >> sourceFor: shader version: version [
	
	^ ShaderCache at: shader
		ifPresent: [:sources |
			| versioned |
			versioned := sources at: version
				ifAbsent: [self error: 'Shader source is missing for ', version].
			versioned, (sources at: #uniforms
				ifPresent: [:uniforms | {#uniforms -> uniforms}]
				ifAbsent: [#()])]
		ifAbsent: [nil]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 4/2/2026 17:42'
}
SRShader class >> stages [

	^ #(vert frag)
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 16:23'
}
SRShader class >> stripInputLocationsForES: glslSource [
	"Strip layout(location=N) from 'in' declarations for GLSL ES 3.0 compatibility."

	| lines stream |
	glslSource ifNil: [^ nil].
	lines := glslSource lines collect: [:line |
		| trimmed rest |
		trimmed := line withBlanksTrimmed.
		(trimmed beginsWith: 'layout(location')
			ifTrue: [
				rest := trimmed copyAfter: $).
				rest := rest withBlanksTrimmed.
				(rest beginsWith: 'in ')
					ifTrue: [rest]
					ifFalse: [line]]
			ifFalse: [line]].
	stream := WriteStream on: (String new: glslSource size).
	lines do: [:line | stream nextPutAll: line; lf].
	^ stream contents
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRShader class >> transpile300es: source stage: stage [
	"Transpile to GLSL ES 3.0, stripping input location qualifiers."

	| out |
	out := self transpile: source stage: stage options: '--version 300 --es'.
	^ self stripInputLocationsForES: out
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 3/10/2026 12:00'
}
SRShader class >> transpile330: source stage: stage [

	^ self transpile: source stage: stage options: '--version 330 --no-420pack-extension --no-es'
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/14/2026 15:42'
}
SRShader class >> transpile: source stage: stage options: options [

	| file output basePath inputFileName shaderFileName |
	[
	basePath := Smalltalk imagePath.
	inputFileName := basePath, '/input.shader'.
	shaderFileName := basePath, '/shader.spv'.
	file := FileStream forceNewFileNamed: 'input.shader'.
	file nextPutAll: source; close.
	self evaluateCommand: ('glslang -G -o {1} {2} -S {3}' format: {
		shaderFileName. inputFileName. stage}).
	output := self evaluateCommand: ('spirv-cross {1} {2}' format: {
		options. shaderFileName})]
		ensure: [FileDirectory default
			deleteFileNamed: inputFileName;
			deleteFileNamed: shaderFileName].
	^ output
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRShader class >> transpileAll [
	self ensureSpirvCrossAvailable; ensureGlslangAvailable.
	^ self transpileAllUnsafe
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 16:09'
}
SRShader class >> transpileAllUnsafe [

	| pragmas duplicates |
	pragmas := self shaderSourcePragmas.
	duplicates := self duplicateShaderNames.
	duplicates ifNotEmpty: [
		Transcript cr; show: '** Duplicate <shaderSource:> names, only the last of each survives the cache: ', duplicates printString].
	self resetCache.
	^ pragmas collect: [:pragma | self transpileShaderDeclaredBy: pragma]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 10:45'
}
SRShader class >> transpileShaderDeclaredBy: aPragma [

	| shaderName |
	shaderName := aPragma arguments first asString.
	ShaderCache ifNil: [self resetCache].
	Transcript cr; show: 'Transpiling shader ', shaderName, '...'.
	ShaderCache
		at: shaderName
		put: (self transpileSource:
			(aPragma methodClass theNonMetaClass perform: aPragma selector)).
	^ shaderName
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 10:46'
}
SRShader class >> transpileShaderNamed: aName [
	| pragma |
	pragma := self shaderSourcePragmas
		detect: [:each | each arguments first asString = aName asString]
		ifNone: [^ self error: 'No method is marked <shaderSource: #', aName asString, '>'].
	self ensureSpirvCrossAvailable; ensureGlslangAvailable.
	^ self transpileShaderDeclaredBy: pragma
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 4/2/2026 17:51'
}
SRShader class >> transpileSource: sourceDict [

	| sources |
	sources := {
		#'330' -> (self stages collect: [:stage |
			stage -> (sourceDict at: stage ifPresent: [:source |
				self transpile330: source stage: stage])
			] as: Dictionary).
		#'300es' -> (self stages collect: [:stage |
			stage -> (sourceDict at: stage ifPresent: [:source |
				self transpile300es: source stage: stage])
			] as: Dictionary).
	} as: Dictionary.
	
	sources addAll: (sourceDict associationsSelect: [:assoc | (self stages includes: assoc key) not]).
	
	^ sources
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:48'
}
SRShader >> fragmentSource [

	^ fragmentSource
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:47'
}
SRShader >> fragmentSource: aString [

	fragmentSource := aString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:49'
}
SRShader >> internalShader [

	^ internalShader
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 8/11/2026 16:04'
}
SRShader >> load [

	SRRenderer assertContext.
	internalShader := Raylib loadShaderFromMemoryVsCode: self vertexSource fsCode: self fragmentSource.
	
	uniformLocs := self uniforms collect: [:uniform |
		uniform -> (Raylib getShaderLocationShader: internalShader uniformName: uniform asString)]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRShader >> uniformLocAt: aUniformName [

	uniformLocs ifNil: [^ -1].
	^ (uniformLocs detect: [:assoc | assoc key = aUniformName] ifNone: [nil])
		ifNil: [-1]
		ifNotNil: [:assoc | assoc value]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 17:55'
}
SRShader >> uniforms [

	^ uniforms
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 17:56'
}
SRShader >> uniforms: aSymbolCollection [

	uniforms := aSymbolCollection
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 16:49'
}
SRShader >> unload [

	Raylib unloadShader: internalShader
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:48'
}
SRShader >> vertexSource [

	^ vertexSource
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:47'
}
SRShader >> vertexSource: aString [

	vertexSource := aString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 16:41'
}
SRShader >> vertexSource: vertexSource fragmentSource: fragmentSource [

	self vertexSource: vertexSource;
		fragmentSource: fragmentSource
]
