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
		'PythonName',
		'ShaderCache'
	],
	#category : #'SqueakXR-Graphics'
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
	#'squeak_changestamp' : 'leo 9/11/2026 13:39'
}
SRShader class >> evaluateCommand: aCommandString [

	OSProcess waitForCommand: aCommandString
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
	#'squeak_changestamp' : 'leo 9/11/2026 12:53'
}
SRShader class >> pythonName [

	<preference: 'Python Name'
		category: 'SqueakXR'
		description: 'The name under which python can be accessed on this system'
		type: #String>
	^ PythonName ifNil: [PythonName := 'python3']
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/11/2026 12:53'
}
SRShader class >> pythonName: aString [

	^ PythonName := aString
]

{
	#category : #transpiling,
	#'squeak_changestamp' : 'leo 9/11/2026 13:40'
}
SRShader class >> pythonTranspileSource [

	^ '
#!/usr/bin/env python3
import sys
import os
import shlex
import subprocess

def evaluate_command(command_args):
    result = subprocess.run(command_args, capture_output=True, text=True)
    if result.returncode != 0:
        printed = " ".join(command_args)
        sys.stderr.write(
            "An error occurred while evaluating ''{0}''\nstdout:\n{1}\nstderr:\n{2}\n".format(
                printed, result.stdout, result.stderr))
        raise RuntimeError("An error occurred while evaluating ''{0}''.".format(printed))
    return result.stdout

def main():
    source_file = sys.argv[1]
    stage = sys.argv[2]
    options = sys.argv[3]
    base_path = sys.argv[4]

    with open(source_file, "r") as f:
        source = f.read()

    input_file_name = os.path.join(base_path, "input.shader")
    shader_file_name = os.path.join(base_path, "shader.spv")
    output_file_name = os.path.join(base_path, "output.shader")

    output = ""
    try:
        with open(input_file_name, "w") as f:
            f.write(source)
        evaluate_command(["glslang", "-G", "-o", shader_file_name, input_file_name, "-S", stage])
        output = evaluate_command(["spirv-cross"] + shlex.split(options) + [shader_file_name])
    finally:
        for path in (input_file_name, shader_file_name):
            try:
                os.remove(path)
            except OSError as e:
                sys.stderr.write("Failed to remove ''{0}'': {1}\n".format(path, e))

    with open(output_file_name, "w") as f:
        f.write(output)

if __name__ == "__main__":
    main()
'
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
	#'squeak_changestamp' : 'leo 9/14/2026 16:49'
}
SRShader class >> setShaderCacheFromJson: aJsonString [

	ShaderCache := Json readFromString: aJsonString
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/14/2026 16:43'
}
SRShader class >> shaderCacheAsJson [

	^ Json render: ShaderCache
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
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer 9/11/2026 12:37'
}
SRShader class >> shellQuote: aString [
	"Wrap aString in POSIX shell single quotes, escaping any embedded
	 single quotes so the result is safe to pass as one shell argument."

	^ String streamContents: [:s |
		s nextPut: $'.
		aString asString do: [:ch |
			ch = $'
				ifTrue: [s nextPutAll: '''\''''']
				ifFalse: [s nextPut: ch]].
		s nextPut: $']
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
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer 9/11/2026 13:38'
}
SRShader class >> transpile: source stage: stage options: options [

	| basePath scriptFileName sourceFileName outputFileName output |
	basePath := Smalltalk imagePath.
	scriptFileName := basePath, '/transpile.py'.
	sourceFileName := basePath, '/source.shader'.
	outputFileName := basePath, '/output.shader'.
	[
	(FileStream forceNewFileNamed: scriptFileName)
		nextPutAll: self pythonTranspileSource;
		close.
	(FileStream forceNewFileNamed: sourceFileName)
		nextPutAll: source asString;
		close.
	self evaluateCommand: ('python3 {1} {2} {3} {4} {5}' format: {
		self shellQuote: scriptFileName.
		self shellQuote: sourceFileName.
		self shellQuote: stage asString.
		self shellQuote: options asString.
		self shellQuote: basePath}).
	output := (FileStream readOnlyFileNamed: outputFileName) contentsOfEntireFile]
		ensure: [FileDirectory default
			deleteFileNamed: scriptFileName;
			deleteFileNamed: sourceFileName;
			deleteFileNamed: outputFileName].
	^ output
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/11/2026 12:45'
}
SRShader class >> transpileAll [

	"self ensureSpirvCrossAvailable; ensureGlslangAvailable."
	^ self transpileAllUnsafe
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/11/2026 12:41'
}
SRShader class >> transpileAllUnsafe [

	| pragmas duplicates |
	pragmas := self shaderSourcePragmas.
	duplicates := self duplicateShaderNames.
	duplicates ifNotEmpty: [
		Transcript cr; show: '** Duplicate <shaderSource:> names, only the last of each survives the cache: ', duplicates printString].
	self resetCache.
	UIManager default informUser: 'Transpiling all shaders...' during: [
		^ pragmas collect: [:pragma | self transpileShaderDeclaredBy: pragma]]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/11/2026 12:41'
}
SRShader class >> transpileShaderDeclaredBy: aPragma [

	| shaderName |
	shaderName := aPragma arguments first asString.
	ShaderCache ifNil: [self resetCache].
	UIManager default informUser: 'Transpiling ', shaderName during: [
		ShaderCache
			at: shaderName
			put: (self transpileSource:
				(aPragma methodClass theNonMetaClass perform: aPragma selector)).
		^ shaderName]
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'leo 9/11/2026 12:44'
}
SRShader class >> transpileShaderNamed: aName [
	| pragma |
	pragma := self shaderSourcePragmas
		detect: [:each | each arguments first asString = aName asString]
		ifNone: [^ self error: 'No method is marked <shaderSource: #', aName asString, '>'].
	"self ensureSpirvCrossAvailable; ensureGlslangAvailable."
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
