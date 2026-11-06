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
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:04'
}
SRMeshObject class >> phong [
	<shaderSource: #phong>

	^ {
		#vert -> self phongVertexSource.
		#frag -> self phongFragmentSource
	} as: Dictionary
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:04'
}
SRMeshObject class >> phongFragmentSource [

	^ '#version 450
', SRLight glslDefines, '#define SHININESS 32.0
#define SPECULAR_STRENGTH 0.5

struct Light
{
    int type;
    vec3 position;
    vec3 direction;
    vec3 color;
    float range;
};

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;
layout(location = 2) in vec3 fragNormal;
layout(location = 3) in vec3 fragPosition;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;
layout(location = 4) uniform vec3 ambientColor;
layout(location = 5) uniform vec3 viewPosition;
layout(location = 6) uniform int lightCount;
layout(location = 7) uniform Light lights[MAX_LIGHTS];

layout(location = 0) out vec4 finalColor;

float attenuation(float lightDistance, float range)
{
    if (range < 0.0) return 1.0;
    if (lightDistance < 0.0) return 0.0;
    float falloff = clamp(1.0 - lightDistance / range, 0.0, 1.0);
    return falloff * falloff;
}

void addLight(Light light, vec3 normal, vec3 viewDirection, inout vec3 diffuse, inout vec3 specular)
{
    vec3 toLight;
    float lightDistance;
    if (light.type == LIGHT_DIRECTIONAL)
    {
        toLight = -light.direction;
        lightDistance = dot(fragPosition - light.position, light.direction);
    }
    else
    {
        vec3 offset = light.position - fragPosition;
        lightDistance = length(offset);
        toLight = offset / max(lightDistance, 0.0001);
    }
    vec3 radiance = light.color * attenuation(lightDistance, light.range);
    float lambert = max(dot(normal, toLight), 0.0);
    diffuse += radiance * lambert;
    if (lambert > 0.0)
        specular += radiance * SPECULAR_STRENGTH * pow(max(dot(viewDirection, reflect(-toLight, normal)), 0.0), SHININESS);
}

void main()
{
    vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
    vec3 normal = normalize(fragNormal);
    vec3 viewDirection = normalize(viewPosition - fragPosition);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);
    for (int i = 0; i < min(lightCount, MAX_LIGHTS); i++)
        addLight(lights[i], normal, viewDirection, diffuse, specular);
    finalColor = vec4(texelColor.rgb * (ambientColor + diffuse) + specular, texelColor.a);
}'
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:04'
}
SRMeshObject class >> phongVertexSource [

	^ '#version 450

layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec2 vertexTexCoord;
layout(location = 2) in vec3 vertexNormal;
layout(location = 3) in vec4 vertexColor;

layout(location = 0) uniform mat4 mvp;
layout(location = 1) uniform mat4 matNormal;
layout(location = 3) uniform mat4 matModel;

layout(location = 0) out vec2 fragTexCoord;
layout(location = 1) out vec4 fragColor;
layout(location = 2) out vec3 fragNormal;
layout(location = 3) out vec3 fragPosition;

void main()
{
    fragTexCoord = vertexTexCoord;
    fragColor = vertexColor;
    fragNormal = normalize(mat3(matNormal) * vertexNormal);
    fragPosition = vec3(matModel * vec4(vertexPosition, 1.0));
    gl_Position = mvp * vec4(vertexPosition, 1.0);
}'
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
	#'squeak_changestamp' : 'leo 9/8/2026 18:04'
}
SRMeshObject >> renderOn: aSRRenderer [

	mesh ifNil: [^ self].
	material ifNil: [^ self].
	"TODO: backface culling should not be on by default, but only in some cases; e.g. SRMorphPanel"
	aSRRenderer withoutBackfaceCullingDo: [
		aSRRenderer
			renderMesh: self mesh
			transform: self globalTransform
			material: material].
]
