Class {
	#name : #SRShader,
	#superclass : #Object,
	#instVars : [
		'source',
		'transpiledSource',
		'source330',
		'source300es',
		'id',
		'internalShader',
		'uniformLocs',
		'name',
		'lightUniforms',
		'floatBuffer',
		'intBuffer'
	],
	#classVars : [
		'Default',
		'Instances',
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:14'
}
SRShader class >> doesNotUnderstand: aMessage [

	^ (self hasCachedShader: aMessage selector)
		ifTrue: [self named: aMessage selector]
		ifFalse: [super doesNotUnderstand: aMessage]
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> hasCachedShader: aName [

	^ self shaderCache includesKey: aName asString
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> instances [

	^ Instances ifNil: [Instances := Dictionary new]
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> named: aSymbol [

	^ self instances
		at: aSymbol asSymbol
		ifAbsentPut: [self new name: aSymbol asSymbol; yourself]
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:34'
}
SRShader class >> pythonTranspileAllSource [

	| shaders |
	shaders := Dictionary new.
	self shaderSourcePragmas do: [:pragma |
		shaders
			at: pragma arguments first asString
			put: (pragma methodClass theNonMetaClass perform: pragma selector)].
	^ (self pythonTranspileAllTemplate
		copyReplaceAll: '$STAGES$' with: (Json render: self stages))
		copyReplaceAll: '$SHADERS$' with: (Json render: shaders)
]

{
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:34'
}
SRShader class >> pythonTranspileAllTemplate [

	^ '#!/usr/bin/env python3
import json
import os
import subprocess
import sys
import tempfile

SHADERS = json.loads(r"""$SHADERS$""")
STAGES = json.loads(r"""$STAGES$""")

def evaluate_command(command_args):
    result = subprocess.run(command_args, capture_output=True, text=True)
    if result.returncode != 0:
        printed = " ".join(command_args)
        sys.stderr.write(
            "An error occurred while evaluating ''{0}''\nstdout:\n{1}\nstderr:\n{2}\n".format(
                printed, result.stdout, result.stderr))
        raise RuntimeError("An error occurred while evaluating ''{0}''.".format(printed))
    return result.stdout

def strip_input_locations_for_es(source):
    lines = []
    for line in source.splitlines():
        trimmed = line.strip()
        if trimmed.startswith("layout(location"):
            rest = trimmed.partition(")")[2].strip()
            if rest.startswith("in "):
                line = rest
        lines.append(line + "\n")
    return "".join(lines)

TARGETS = [
    ("330", ["--version", "330", "--no-420pack-extension", "--no-es"], lambda source: source),
    ("300es", ["--version", "300", "--es"], strip_input_locations_for_es),
]

def transpile(source, stage, options, base_path):
    input_file_name = os.path.join(base_path, "input.shader")
    shader_file_name = os.path.join(base_path, "shader.spv")
    with open(input_file_name, "w") as f:
        f.write(source)
    evaluate_command(["glslang", "-G", "-o", shader_file_name, input_file_name, "-S", stage])
    return evaluate_command(["spirv-cross"] + options + [shader_file_name])

def transpile_shader(sources, base_path):
    result = dict()
    for version, options, post_process in TARGETS:
        result[version] = dict(
            (stage, post_process(transpile(sources[stage], stage, options, base_path)) if stage in sources else None)
            for stage in STAGES)
    for key, value in sources.items():
        if key not in STAGES:
            result[key] = value
    return result

def main():
    if len(sys.argv) > 1:
        output_file_name = sys.argv[1]
    else:
        output_file_name = os.path.join(os.path.dirname(os.path.abspath(__file__)), "shaders.json")
    cache = dict()
    with tempfile.TemporaryDirectory() as base_path:
        for name in sorted(SHADERS):
            print("Transpiling " + name)
            cache[name] = transpile_shader(SHADERS[name], base_path)
    with open(output_file_name, "w") as f:
        json.dump(cache, f)

if __name__ == "__main__":
    main()
'
]

{
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:29'
}
SRShader class >> pythonTranspileFileName [

	^ (FileDirectory on: Smalltalk imagePath) fullNameFor: 'transpile.py'
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> resetCache [

	self shaderCache: Dictionary new.
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> setShaderCacheFromJson: aJsonString [

	self shaderCache: (Json readFromString: aJsonString).
]

{
	#category : #'shader cache',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> shaderCache [

	^ ShaderCache ifNil: [ShaderCache := Dictionary new]
]

{
	#category : #'shader cache',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> shaderCache: aDictionary [

	ShaderCache := aDictionary.
	self unloadAllShaders.
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> shaderCacheAsJson [

	^ Json render: self shaderCache
]

{
	#category : #'shader cache',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> shaderCacheAt: aName put: aDictionary [

	self shaderCache at: aName asString put: aDictionary.
	self unloadShaderNamed: aName.
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> sourceFor: shader version: version [
	
	^ self shaderCache at: shader asString
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:27'
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> transpileShaderDeclaredBy: aPragma [

	| shaderName |
	shaderName := aPragma arguments first asString.
	UIManager default informUser: 'Transpiling ', shaderName during: [
		self
			shaderCacheAt: shaderName
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
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> unloadAllShaders [

	self instances do: [:shader | shader unload].
]

{
	#category : #shaders,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader class >> unloadShaderNamed: aName [

	self instances at: aName asSymbol ifPresent: [:shader | shader unload].
]

{
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:27'
}
SRShader class >> writePythonTranspileSource [

	self writePythonTranspileSourceTo: self pythonTranspileFileName
]

{
	#category : #transpiling,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:34'
}
SRShader class >> writePythonTranspileSourceTo: aFileName [

	(FileStream forceNewFileNamed: aFileName)
		nextPutAll: self pythonTranspileAllSource withUnixLineEndings;
		close
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRShader >> assignSamplerLocations [

	| location |
	location := self locationOf: 'environmentMap'.
	location >= 0 ifTrue: [
		internalShader locs
			at: RlShaderLocationIndex shaderLocMapCubemap + 1
			put: location].
]

{
	#category : #finalization,
	#'squeak_changestamp' : 'leo 10/15/2026 15:25'
}
SRShader >> finalize [

	internalShader ifNotNil: [
		SRRenderer hasContext ifTrue: [
			Raylib unloadShader: internalShader]].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'leo 11/4/2026 14:16'
}
SRShader >> initialize [

	super initialize.
	floatBuffer := ByteArray new: 12.
	intBuffer := ByteArray new: 4.
	Smalltalk addToShutDownList: self.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:19'
}
SRShader >> internalShader [

	internalShader ifNil: [self loadInternalShader].
	^ internalShader
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRShader >> lightUniforms [

	self internalShader.
	^ lightUniforms
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRShader >> loadInternalShader [

	| sources |
	SRRenderer assertContext.
	sources := self class sourceFor: name version: self currentXRWorld renderer shaderVersion.
	internalShader := Raylib loadShaderFromMemoryVsCode: (sources at: #vert) fsCode: (sources at: #frag).
	uniformLocs := (sources at: #uniforms ifAbsent: [#()]) collect: [:uniform |
		uniform -> (self locationOf: uniform)].
	self assignSamplerLocations; loadLightUniforms.
	FinalizationRegistry default add: self.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRShader >> loadLightUniforms [

	lightUniforms := (SRLightUniforms isUsedBy: self)
		ifTrue: [SRLightUniforms forShader: self]
		ifFalse: [nil].
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> locationOf: aUniformName [

	^ Raylib getShaderLocationShader: self internalShader uniformName: aUniformName asString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:14'
}
SRShader >> name [

	^ name
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:14'
}
SRShader >> name: aSymbol [

	name := aSymbol.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:19'
}
SRShader >> onCacheInvalidated [

	self unload.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:08'
}
SRShader >> setColor: aColor intensity: aNumber at: aLocation [

	self
		setX: aColor red * aNumber
		y: aColor green * aNumber
		z: aColor blue * aNumber
		at: aLocation.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> setFloat: aNumber at: aLocation [

	floatBuffer floatAt: 1 put: aNumber asFloat.
	self setValue: floatBuffer type: RlShaderUniformDataType shaderUniformFloat at: aLocation.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> setInt: anInteger at: aLocation [

	intBuffer signedLongAt: 1 put: anInteger.
	self setValue: intBuffer type: RlShaderUniformDataType shaderUniformInt at: aLocation.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> setValue: aByteArray type: aUniformType at: aLocation [

	aLocation < 0 ifTrue: [^ self].
	Raylib
		setShaderValueShader: self internalShader
		locIndex: aLocation
		value: aByteArray
		uniformType: aUniformType.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> setVector: aVector3 at: aLocation [

	self setX: aVector3 x y: aVector3 y z: aVector3 z at: aLocation.
]

{
	#category : #uniforms,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:25'
}
SRShader >> setX: x y: y z: z at: aLocation [

	floatBuffer
		floatAt: 1 put: x asFloat;
		floatAt: 5 put: y asFloat;
		floatAt: 9 put: z asFloat.
	self setValue: floatBuffer type: RlShaderUniformDataType shaderUniformVec3 at: aLocation.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'leo 11/4/2026 14:17'
}
SRShader >> shutDown: quitting [

	quitting ifTrue: [
		self unloadAllShaders].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:19'
}
SRShader >> uniformLocAt: aUniformName [

	self internalShader.
	^ (uniformLocs detect: [:assoc | assoc key = aUniformName] ifNone: [nil])
		ifNil: [-1]
		ifNotNil: [:assoc | assoc value]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:54'
}
SRShader >> unload [

	internalShader ifNil: [^ self].
	FinalizationRegistry default remove: self ifAbsent: [].
	SRRenderer hasContext ifTrue: [Raylib unloadShader: internalShader].
	internalShader := nil.
	uniformLocs := nil.
	lightUniforms := nil.
	self changed: #shaderUnloaded.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/2/2026 15:15'
}
SRShader >> uploadLights: aCollection ambientColor: aColor viewPosition: aVector3 [

	self lightUniforms ifNotNil: [:uniforms |
		uniforms
			uploadLights: aCollection
			ambientColor: aColor
			viewPosition: aVector3].
]
