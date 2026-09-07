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
	#'squeak_changestamp' : 'jl 8/11/2026 15:52'
}
SRShaderTest >> testNoDuplicateShaderNames [

	self assert: SRShader duplicateShaderNames isEmpty
]
