"
An SRObject that draws an SRMesh with an SRMaterial at its own world transform. One DrawMesh call per frame per object.

ivars:
  mesh      an SRMesh
  material  an SRMaterial
"
Class {
	#name : #SRMeshObject,
	#superclass : #SRObject,
	#instVars : [
		'mesh',
		'material'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : 'lege 7/15/2026 16:17'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/8/2026 14:27'
}
SRMeshObject class >> fromSource: aSRMeshSource [

	^ self withMesh: (SRMesh withSource: aSRMeshSource)
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 18:17'
}
SRMeshObject class >> phong [
	<shaderSource: #phong>
	"Textured mesh lit by one fixed directional light."

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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/8/2026 14:26'
}
SRMeshObject class >> withMesh: aSRMesh [

	^ self new mesh: aSRMesh
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> initialize [
	super initialize.
	material := SRMaterial new
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> material [
	^ material
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> material: anSRMaterial [
	material := anSRMaterial
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> mesh [
	^ mesh
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:49'
}
SRMeshObject >> mesh: anSRMesh [

	mesh := anSRMesh
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/15/2026 19:04'
}
SRMeshObject >> onCacheInvalidated [

	super onCacheInvalidated.
	
	self mesh ifNotNil: #onCacheInvalidated.
	self material onCacheInvalidated.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/15/2026 14:08'
}
SRMeshObject >> renderOn: aSRRenderer [

	mesh ifNil: [^ self].
	material ifNil: [^ self].
	aSRRenderer withoutBackfaceCullingDo: [
		aSRRenderer
			renderMesh: self mesh
			transform: self globalTransform
			material: material].
]
