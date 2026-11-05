"
Tests the <shaderSource:> declaration mechanism, not the shaders themselves: transpiling needs glslang and spirv-cross, which are not available everywhere.
"
Class {
	#name : #SRShaderTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:38'
}
SRShaderTest >> testDiscardingForgetsTheNativeHandle [

	| shader stillRegistered |
	shader := SRShader new.
	shader instVarNamed: 'internalShader' put: RlShader new.
	FinalizationRegistry default add: shader.

	shader discardExternalObjects.

	self assert: (shader instVarNamed: 'internalShader') isNil.
	stillRegistered := true.
	FinalizationRegistry default remove: shader ifAbsent: [stillRegistered := false].
	self deny: stillRegistered.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl 8/11/2026 15:52'
}
SRShaderTest >> testDuplicateShaderNamesFindsAClash [

	| taken |
	taken := SRShader shaderNames first.
	[SRShaderTest class
		compile: 'clashingShaderSourceProbe
	<shaderSource: #', taken, '>
	^ Dictionary new'
		classified: 'shader sources'.
	self assert: (SRShader duplicateShaderNames includes: taken)]
		ensure: [SRShaderTest class removeSelector: #clashingShaderSourceProbe].

	self deny: (SRShader duplicateShaderNames includes: taken)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:55'
}
SRShaderTest >> testNamedReturnsOneInstancePerName [

	[self assert: (SRShader named: #srShaderTestProbe) == (SRShader named: 'srShaderTestProbe')]
		ensure: [SRShader instances removeKey: #srShaderTestProbe ifAbsent: []].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:38'
}
SRShaderTest >> testNativeHandleHoldersStartUpBeforeTheWorld [
	"Handles saved with the image point into the previous process; SRWorld>>startUp: renders with them."

	| list worldIndex |
	list := SmalltalkImage classPool at: #StartUpList.
	worldIndex := list indexOf: #SRWorld.
	#(#SRShader #SRMesh #SRTexture #SRTextureSource) do: [:name |
		self assert: ((list indexOf: name) between: 1 and: worldIndex - 1)].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl 8/11/2026 15:52'
}
SRShaderTest >> testNoDuplicateShaderNames [

	self assert: SRShader duplicateShaderNames isEmpty
]
