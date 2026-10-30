"
A large cube textured with a cubemap. Attach it to the camera so it follows the viewer; the shader samples in world directions, so the sky stays fixed while the head turns.
"
Class {
	#name : #SRSkyBox,
	#superclass : #SRMeshObject,
	#classVars : [
		'Sky'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 18:02'
}
SRSkyBox class >> assetsDirectory [

	^ (({GSBaseWorkingCopy. GSGitWorkingCopy} collect: [:class |
		class named: 'SqueakXRNative' ifAbsent: [nil]]) detect: #notNil)
			repository workingDir / 'assets'
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'leo 10/30/2026 16:27'
}
SRSkyBox class >> defaultSize [

	^ 2300
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 14:03'
}
SRSkyBox class >> sky [

	<preference: 'Skybox'
		category: 'SqueakXR'
		description: 'One of day1, day2, night1, night2, night3, night4'
		type: #String>
	^ Sky ifNil: [#day1]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 18:04'
}
SRSkyBox class >> sky: aSymbol [

	Sky := aSymbol ifNotNil: [aSymbol asSymbol].
	self allInstancesDo: [:each | each reloadTexture].
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 14:03'
}
SRSkyBox class >> skyAssetNames [

	^ Dictionary newFrom: {
		#day1 -> 'DaySkyHDRI069B'.
		#day2 -> 'DaySkyHDRI027B'.
		#night1 -> 'NightSkyHDRI003'.
		#night2 -> 'NightSkyHDRI008'.
		#night3 -> 'NightSkyHDRI001'.
		#night4 -> 'NightSkyHDRI007'}
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:56'
}
SRSkyBox class >> skybox [
	<shaderSource: #skybox>

	^ {
		#vert -> '#version 450

layout(location = 0) in vec3 vertexPosition;

layout(location = 0) uniform mat4 mvp;
layout(location = 1) uniform mat4 matModel;

layout(location = 0) out vec3 fragDirection;

void main()
{
    vec4 eye = inverse(mvp) * vec4(0.0, 0.0, 1.0, 0.0);
    fragDirection = mat3(matModel) * (vertexPosition - eye.xyz / eye.w);
    gl_Position = mvp * vec4(vertexPosition, 1.0);
}'.
		#frag -> '#version 450

layout(location = 0) in vec3 fragDirection;

layout(binding = 0) uniform samplerCube environmentMap;

layout(location = 0) out vec4 finalColor;

void main()
{
    finalColor = texture(environmentMap, fragDirection);
}'
	} as: Dictionary
]

{
	#category : #defaults,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 18:05'
}
SRSkyBox class >> textureFullPath [

	^ (self skyAssetNames at: self sky) in: [:assetName |
		(self assetsDirectory / (assetName, '_4K') / (assetName, '_cubemap.png')) fullName]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRSkyBox >> initialize [

	super initialize.
	self mesh: (SRMesh withSource: (SRMeshSourceRaylibGen cubeWidth: 1 height: 1 length: 1)).
	self scale: self class defaultSize asVector3.
	material shader: (SRShader named: #skybox).
	material cubemap: (SRTexture withSource: (SRTextureSourceCubemapFile path: self class textureFullPath)).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:56'
}
SRSkyBox >> reloadTexture [

	material cubemap source path: self class textureFullPath
]
