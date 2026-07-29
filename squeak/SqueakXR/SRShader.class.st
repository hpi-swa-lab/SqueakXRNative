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
	#'squeak_changestamp' : 'lege 7/16/2026 18:11'
}
SRShader class >> cache: aName source: aSourceDict [
	self deprecated.
	"Transpile and cache a single named shader source on demand.
	 aSourceDict is a {#vert. #frag. #uniforms} dictionary in #version 450 form."
	self ensureSpirvCrossAvailable; ensureGlslangAvailable.
	ShaderCache ifNil: [ShaderCache := Dictionary new].
	ShaderCache at: aName asString put: (self transpileSource: aSourceDict).
	^ aName
]

{
	#category : #'app shaders',
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
	#category : #'app shaders',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRShader class >> hasCachedShader: aName [

	^ ShaderCache notNil and: [ShaderCache includesKey: aName asString]
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'lege 7/29/2026 16:41'
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
      finalColor = texelColor.bgra;
}'
} as: Dictionary
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'lege 7/15/2026 12:58'
}
SRShader class >> phongSource [

	^ {
		#vert -> '#version 450

layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec2 vertexTexCoord;
layout(location = 2) in vec3 vertexNormal;
layout(location = 3) in vec4 vertexColor;

layout(location = 0) uniform mat4 mvp;
layout(location = 1) uniform mat4 matNormal;

layout(location = 0) out vec2 fragTexCoord;
layout(location = 1) out vec4 fragColor;
layout(location = 2) out vec3 fragNormal;

void main()
{
    fragTexCoord = vertexTexCoord;
    fragColor = vertexColor;
    fragNormal = normalize(vec3(matNormal*vec4(vertexNormal, 1.0)));

    gl_Position = mvp*vec4(vertexPosition, 1.0);
}'.
		#frag -> '
#version 450

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;
layout(location = 2) in vec3 fragNormal;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;

layout(location = 0) out vec4 finalColor;

void main()
{
      vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
	vec3 lightDirection = normalize(vec3(0.5, -1.0, -0.25));
	vec3 diffuse = vec3(max(0.05, dot(normalize(fragNormal), -lightDirection)));
      finalColor = texelColor * vec4(diffuse, 1.0);
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
	#'squeak_changestamp' : 'lege 7/15/2026 11:02'
}
SRShader class >> transpileAll [

	self ensureSpirvCrossAvailable; ensureGlslangAvailable;
		transpileAllUnsafe.
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/16/2026 19:09'
}
SRShader class >> transpileAllUnsafe [

	self resetCache.

	UIManager default informUser: 'Transpiling all shaders...' during: [
		(self class selectorsInCategory: #'shader sources') do: [:selector |
			self transpileSingleSourceAtUnsafe: selector]]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/15/2026 11:00'
}
SRShader class >> transpileSingleSourceAt: selector [

	self ensureSpirvCrossAvailable; ensureGlslangAvailable;
		transpileSingleSourceAtUnsafe: selector.
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 7/16/2026 19:09'
}
SRShader class >> transpileSingleSourceAtUnsafe: selector [

	ShaderCache ifNil: [self resetCache].
	
	UIManager default informUser: 'Transpiling ', selector, '...' during: [
		ShaderCache
			at: (selector allButLast: 'Source' size)
			put: (self transpileSource: (self perform: selector))]
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
	#'squeak_changestamp' : 'MCPServer 7/29/2026 12:44'
}
SRShader >> load [

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
