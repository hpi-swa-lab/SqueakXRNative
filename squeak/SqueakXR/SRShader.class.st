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
		'internalShader'
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
	#category : #shaders,
	#'squeak_changestamp' : 'lege 4/2/2026 17:14'
}
SRShader class >> doesNotUnderstand: aMessage [

	^ (self sourceFor: aMessage selector version: self currentXRWorld renderer shaderVersion)
		ifNotNil: [:source |
			self new vertexSource: (source at: #vert) fragmentSource: (source at: #frag)]
		ifNil: [super doesNotUnderstand: aMessage]
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'lege 3/10/2026 17:21'
}
SRShader class >> morphicPanelSource [

	^ {
		#vert -> nil.

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
	#'squeak_changestamp' : 'lege 3/11/2026 14:59'
}
SRShader class >> sourceFor: shader version: version [

	^ ShaderCache at: shader
		ifPresent: [:sources |
			sources at: version
				ifAbsent: [self error: 'Shader source is missing for ', version]]
		ifAbsent: [nil]
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
	#'squeak_changestamp' : 'lege 3/10/2026 17:06'
}
SRShader class >> transpile: source stage: stage options: options [

	| file output |
	[file := FileStream forceNewFileNamed: 'input.shader'.
	file nextPutAll: source; close.
	OSProcess waitForCommand: 'glslang -G -o shader.spv input.shader -S ', stage.
	output := OSProcess outputOf: 'spirv-cross ', options, ' shader.spv']
		ensure: [FileDirectory default deleteFileNamed: 'input.shader'; deleteFileNamed: 'shader.spv'].
	^ output
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 3/10/2026 17:37'
}
SRShader class >> transpileAll [

	self resetCache.
	
	UIManager default informUser: 'Transpiling...' during: [
		ShaderCache := (self class selectorsInCategory: #'shader sources') collect: [:selector |
			UIManager default informUser: selector during: [
				(selector allButLast: 'Source' size) -> (self transpileSource: (self perform: selector))].
			] as: Dictionary]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'lege 3/11/2026 17:52'
}
SRShader class >> transpileSource: sourceDict [

	^ {
		#'330' -> (sourceDict associations collect: [:stageAndSource | | stage |
			stage := stageAndSource key.
			stage -> (stageAndSource value ifNotNil: [:source |
				(self transpile330: source stage: stage)])
			] as: Dictionary).
		#'300es' -> (sourceDict associations collect: [:stageAndSource | | stage |
			stage := stageAndSource key.
			stage -> (stageAndSource value ifNotNil: [:source |
				(self transpile300es: source stage: stage)])
			] as: Dictionary).
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
	#'squeak_changestamp' : 'lege 3/11/2026 17:54'
}
SRShader >> load [

	internalShader := Raylib loadShaderFromMemoryVsCode: self vertexSource fsCode: self fragmentSource
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
