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
	#category : #shaders,
	#'squeak_changestamp' : 'lege 3/10/2026 11:41'
}
SRShader class >> allShaderSelectors [

	self class selectorsInCategory: #shaders
]

{
	#category : #'app shaders',
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:39'
}
SRShader class >> cache: aName source: aSourceDict [
	"Transpile and cache a single named shader source on demand.
	 Lets application packages (e.g. SWAGame) own their shader source methods
	 instead of adding them to SRShader's own 'shader sources' category.
	 aName is the cache key used later by DNU dispatch (e.g. SRShader swagameVoxelEdge).
	 aSourceDict is a {#vert. #frag. #uniforms} dictionary in #version 450 form.
	 Requires glslang + spirv-cross (same prerequisites as transpileAll)."
	self ensureSpirvCrossAvailable; ensureGlslangAvailable.
	ShaderCache ifNil: [ShaderCache := Dictionary new].
	ShaderCache at: aName asString put: (self transpileSource: aSourceDict).
	^ aName
]

{
	#category : #'app shaders',
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:48'
}
SRShader class >> canTranspile [
	"Answer whether the GLSL transpile toolchain (glslang + spirv-cross) is
	 available on this platform. False on the Meta Quest (Android), where shaders
	 must be pre-transpiled on desktop and read from a saved ShaderCache."
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
	#'squeak_changestamp' : 'lege 4/2/2026 17:35'
}
SRShader class >> doesNotUnderstand: aMessage [

	^ (self sourceFor: aMessage selector version: self currentXRWorld renderer shaderVersion)
		ifNotNil: [:source | self shaderFromDict: source]
		ifNil: [super doesNotUnderstand: aMessage]
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
	#category : #'app shaders',
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:40'
}
SRShader class >> hasCachedShader: aName [
	"Answer whether a shader source has been transpiled and cached under aName."
	^ ShaderCache notNil and: [ShaderCache includesKey: aName asString]
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'lege 4/2/2026 17:45'
}
SRShader class >> morphicPanelSource [

	^ {
		#frag -> '
#version 450

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;

layout(location = 0) out vec4 finalColor;

void main()
{
      vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
      finalColor = texelColor.gbar;
}'
} as: Dictionary
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
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:28'
}
SRShader class >> sourceFor: shader version: version [
	"Return the {vert. frag} source dict for the given shader name and GLSL
	 version, with any shader-wide #uniforms list (stored at the top level of
	 the cache entry by transpileSource:) merged in so shaderFromDict: can see it."
	^ ShaderCache at: shader
		ifPresent: [:sources |
			| versioned |
			versioned := sources at: version
				ifAbsent: [self error: 'Shader source is missing for ', version].
			(sources includesKey: #uniforms)
				ifTrue: [versioned , { #uniforms -> (sources at: #uniforms) } ]
				ifFalse: [versioned]]
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
	#'squeak_changestamp' : 'lege 3/10/2026 12:00'
}
SRShader class >> transpile300es: source stage: stage [

	^ self transpile: source stage: stage options: '--version 300 --es'
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
	#'squeak_changestamp' : 'lege 5/6/2026 13:29'
}
SRShader class >> transpile: source stage: stage options: options [

	| file output basePath inputFileName shaderFileName |
	[
	basePath := Smalltalk imagePath.
	inputFileName := basePath, '/input.shader'.
	shaderFileName := basePath, '/shader.spv'.
	file := FileStream forceNewFileNamed: 'input.shader'.
	file nextPutAll: source; close.
	OSProcess waitForCommand: ('glslang -G -o {1} {2} -S {3}' format: {
		shaderFileName. inputFileName. stage}).
	output := OSProcess outputOf: ('spirv-cross {1} {2}' format: {options. shaderFileName})]
		ensure: [FileDirectory default
			deleteFileNamed: inputFileName;
			deleteFileNamed: shaderFileName].
	^ output
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:41'
}
SRShader class >> transpileAll [
	"Transpile SRShader's own 'shader sources' (framework shaders) into ShaderCache.
	 App-registered shaders (added via cache:source:) are preserved: we merge the
	 framework sources into the existing cache rather than replacing it wholesale."

	self ensureSpirvCrossAvailable; ensureGlslangAvailable.

	ShaderCache ifNil: [ShaderCache := Dictionary new].

	UIManager default informUser: 'Transpiling...' during: [
		(self class selectorsInCategory: #'shader sources') do: [:selector |
			UIManager default informUser: selector during: [
				ShaderCache
					at: (selector allButLast: 'Source' size)
					put: (self transpileSource: (self perform: selector))]]]
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
	#category : #'shader sources',
	#'squeak_changestamp' : 'lege 4/2/2026 17:52'
}
SRShader class >> waterShaderSource [

	^ {
		#uniforms -> #(time).
		#frag -> '
#version 450

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;

layout(location = 0) out vec4 finalColor;

void main()
{
      vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
      finalColor = texelColor;
}'
} as: Dictionary
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
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:30'
}
SRShader >> load [

	internalShader := Raylib loadShaderFromMemoryVsCode: self vertexSource fsCode: self fragmentSource.
	
	uniformLocs := self uniforms collect: [:uniform |
		uniform -> (Raylib getShaderLocationShader: internalShader uniformName: uniform asString)]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 17:27'
}
SRShader >> uniformLocAt: aUniformName [
	"Return the cached GL location of the named uniform (set during #load from
	 the #uniforms list), or -1 if this shader does not declare it."
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
