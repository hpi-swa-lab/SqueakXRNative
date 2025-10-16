Class {
	#name : #RlFunctions,
	#superclass : #ExternalLibrary,
	#category : #'Raylib-Functions-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions class >> moduleName [

	^ 'squeakxrnative'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginBlendMode: mode [
	"Begin blending mode (alpha, additive, multiplied, subtract, custom)
	mode - int"
	<generated>
	<cdecl: void 'BeginBlendMode' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginDrawing [
	"Setup canvas (framebuffer) to start drawing
"
	<generated>
	<cdecl: void 'BeginDrawing' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginMode2DCamera: camera [
	"Begin 2D mode with custom camera (2D)
	camera - Camera2D"
	<generated>
	<cdecl: void 'BeginMode2D' (RlCamera2D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginMode3DCamera: camera [
	"Begin 3D mode with custom camera (3D)
	camera - Camera3D"
	<generated>
	<cdecl: void 'BeginMode3D' (RlCamera3D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginScissorModeX: x y: y width: width height: height [
	"Begin scissor mode (define screen area for following drawing)
	x - int
	y - int
	width - int
	height - int"
	<generated>
	<cdecl: void 'BeginScissorMode' (int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginShaderModeShader: shader [
	"Begin custom shader drawing
	shader - Shader"
	<generated>
	<cdecl: void 'BeginShaderMode' (RlShader)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginTextureModeTarget: target [
	"Begin drawing to render texture
	target - RenderTexture2D"
	<generated>
	<cdecl: void 'BeginTextureMode' (RlRenderTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> beginVrStereoModeConfig: config [
	"Begin stereo rendering (requires VR simulator)
	config - VrStereoConfig"
	<generated>
	<cdecl: void 'BeginVrStereoMode' (RlVrStereoConfig)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> changeDirectoryDir: dir [
	"Change working directory, return true on success
	dir - const char *"
	<generated>
	<cdecl: bool 'ChangeDirectory' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionBoxSphereBox: box center: center radius: radius [
	"Check collision between box and sphere
	box - BoundingBox
	center - Vector3
	radius - float"
	<generated>
	<cdecl: bool 'CheckCollisionBoxSphere' (RlBoundingBox, RlVector3, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionBoxesBox1: box1 box2: box2 [
	"Check collision between two bounding boxes
	box1 - BoundingBox
	box2 - BoundingBox"
	<generated>
	<cdecl: bool 'CheckCollisionBoxes' (RlBoundingBox, RlBoundingBox)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionCircleLineCenter: center radius: radius p1: p1 p2: p2 [
	"Check if circle collides with a line created betweeen two points [p1] and [p2]
	center - Vector2
	radius - float
	p1 - Vector2
	p2 - Vector2"
	<generated>
	<cdecl: bool 'CheckCollisionCircleLine' (RlVector2, float, RlVector2, RlVector2)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionCircleRecCenter: center radius: radius rec: rec [
	"Check collision between circle and rectangle
	center - Vector2
	radius - float
	rec - Rectangle"
	<generated>
	<cdecl: bool 'CheckCollisionCircleRec' (RlVector2, float, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionCirclesCenter1: center1 radius1: radius1 center2: center2 radius2: radius2 [
	"Check collision between two circles
	center1 - Vector2
	radius1 - float
	center2 - Vector2
	radius2 - float"
	<generated>
	<cdecl: bool 'CheckCollisionCircles' (RlVector2, float, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionLinesStartPos1: startPos1 endPos1: endPos1 startPos2: startPos2 endPos2: endPos2 collisionPoint: collisionPoint [
	"Check the collision between two lines defined by two points each, returns collision point by reference
	startPos1 - Vector2
	endPos1 - Vector2
	startPos2 - Vector2
	endPos2 - Vector2
	collisionPoint - Vector2 *"
	<generated>
	<cdecl: bool 'CheckCollisionLines' (RlVector2, RlVector2, RlVector2, RlVector2, RlVector2*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionPointCirclePoint: point center: center radius: radius [
	"Check if point is inside circle
	point - Vector2
	center - Vector2
	radius - float"
	<generated>
	<cdecl: bool 'CheckCollisionPointCircle' (RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionPointLinePoint: point p1: p1 p2: p2 threshold: threshold [
	"Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
	point - Vector2
	p1 - Vector2
	p2 - Vector2
	threshold - int"
	<generated>
	<cdecl: bool 'CheckCollisionPointLine' (RlVector2, RlVector2, RlVector2, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionPointPolyPoint: point points: points pointCount: pointCount [
	"Check if point is within a polygon described by array of vertices
	point - Vector2
	points - const Vector2 *
	pointCount - int"
	<generated>
	<cdecl: bool 'CheckCollisionPointPoly' (RlVector2, RlVector2*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionPointRecPoint: point rec: rec [
	"Check if point is inside rectangle
	point - Vector2
	rec - Rectangle"
	<generated>
	<cdecl: bool 'CheckCollisionPointRec' (RlVector2, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionPointTrianglePoint: point p1: p1 p2: p2 p3: p3 [
	"Check if point is inside a triangle
	point - Vector2
	p1 - Vector2
	p2 - Vector2
	p3 - Vector2"
	<generated>
	<cdecl: bool 'CheckCollisionPointTriangle' (RlVector2, RlVector2, RlVector2, RlVector2)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionRecsRec1: rec1 rec2: rec2 [
	"Check collision between two rectangles
	rec1 - Rectangle
	rec2 - Rectangle"
	<generated>
	<cdecl: bool 'CheckCollisionRecs' (RlRectangle, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> checkCollisionSpheresCenter1: center1 radius1: radius1 center2: center2 radius2: radius2 [
	"Check collision between two spheres
	center1 - Vector3
	radius1 - float
	center2 - Vector3
	radius2 - float"
	<generated>
	<cdecl: bool 'CheckCollisionSpheres' (RlVector3, float, RlVector3, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> clearBackgroundColor: color [
	"Set background color (framebuffer clear color)
	color - Color"
	<generated>
	<cdecl: void 'ClearBackground' (RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> clearWindowStateFlags: flags [
	"Clear window configuration state flags
	flags - unsigned int"
	<generated>
	<cdecl: void 'ClearWindowState' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> closeWindow [
	"Close window and unload OpenGL context
"
	<generated>
	<cdecl: void 'CloseWindow' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> codepointToUTF8Codepoint: codepoint utf8Size: utf8Size [
	"Encode one codepoint into UTF-8 byte array (array length returned as parameter)
	codepoint - int
	utf8Size - int *"
	<generated>
	<cdecl: char8_t* 'CodepointToUTF8' (int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorAlphaBlendDst: dst src: src tint: tint [
	"Get src alpha-blended into dst color with tint
	dst - Color
	src - Color
	tint - Color"
	<generated>
	<cdecl: RlColor 'ColorAlphaBlend' (RlColor, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorAlphaColor: color alpha: alpha [
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f
	color - Color
	alpha - float"
	<generated>
	<cdecl: RlColor 'ColorAlpha' (RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorBrightnessColor: color factor: factor [
	"Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
	color - Color
	factor - float"
	<generated>
	<cdecl: RlColor 'ColorBrightness' (RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorContrastColor: color contrast: contrast [
	"Get color with contrast correction, contrast values between -1.0f and 1.0f
	color - Color
	contrast - float"
	<generated>
	<cdecl: RlColor 'ColorContrast' (RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorFromHSVHue: hue saturation: saturation value: value [
	"Get a Color from HSV values, hue [0..360], saturation/value [0..1]
	hue - float
	saturation - float
	value - float"
	<generated>
	<cdecl: RlColor 'ColorFromHSV' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorFromNormalized: normalized [
	"Get Color from normalized values [0..1]
	normalized - Vector4"
	<generated>
	<cdecl: RlColor 'ColorFromNormalized' (RlVector4)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorIsEqualCol1: col1 col2: col2 [
	"Check if two colors are equal
	col1 - Color
	col2 - Color"
	<generated>
	<cdecl: bool 'ColorIsEqual' (RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorLerpColor1: color1 color2: color2 factor: factor [
	"Get color lerp interpolation between two colors, factor [0.0f..1.0f]
	color1 - Color
	color2 - Color
	factor - float"
	<generated>
	<cdecl: RlColor 'ColorLerp' (RlColor, RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorNormalizeColor: color [
	"Get Color normalized as float [0..1]
	color - Color"
	<generated>
	<cdecl: RlVector4 'ColorNormalize' (RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorTintColor: color tint: tint [
	"Get color multiplied with another color
	color - Color
	tint - Color"
	<generated>
	<cdecl: RlColor 'ColorTint' (RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorToHSVColor: color [
	"Get HSV values for a Color, hue [0..360], saturation/value [0..1]
	color - Color"
	<generated>
	<cdecl: RlVector3 'ColorToHSV' (RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> colorToIntColor: color [
	"Get hexadecimal value for a Color (0xRRGGBBAA)
	color - Color"
	<generated>
	<cdecl: int32_t 'ColorToInt' (RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> compressData: data dataSize: dataSize compDataSize: compDataSize [
	"Compress data (DEFLATE algorithm), memory must be MemFree()
	data - const unsigned char *
	dataSize - int
	compDataSize - int *"
	<generated>
	<cdecl: uchar8_t* 'CompressData' (uchar8_t*, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> computeCRC32Data: data dataSize: dataSize [
	"Compute CRC32 hash code
	data - unsigned char *
	dataSize - int"
	<generated>
	<cdecl: uint32_t 'ComputeCRC32' (uchar8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> computeMD5Data: data dataSize: dataSize [
	"Compute MD5 hash code, returns static int[4] (16 bytes)
	data - unsigned char *
	dataSize - int"
	<generated>
	<cdecl: uint32_t* 'ComputeMD5' (uchar8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> computeSHA1Data: data dataSize: dataSize [
	"Compute SHA1 hash code, returns static int[5] (20 bytes)
	data - unsigned char *
	dataSize - int"
	<generated>
	<cdecl: uint32_t* 'ComputeSHA1' (uchar8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> decodeDataBase64Data: data outputSize: outputSize [
	"Decode Base64 string data, memory must be MemFree()
	data - const unsigned char *
	outputSize - int *"
	<generated>
	<cdecl: uchar8_t* 'DecodeDataBase64' (uchar8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> decompressDataCompData: compData compDataSize: compDataSize dataSize: dataSize [
	"Decompress data (DEFLATE algorithm), memory must be MemFree()
	compData - const unsigned char *
	compDataSize - int
	dataSize - int *"
	<generated>
	<cdecl: uchar8_t* 'DecompressData' (uchar8_t*, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> directoryExistsDirPath: dirPath [
	"Check if a directory path exists
	dirPath - const char *"
	<generated>
	<cdecl: bool 'DirectoryExists' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> disableCursor [
	"Disables cursor (lock cursor)
"
	<generated>
	<cdecl: void 'DisableCursor' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> disableEventWaiting [
	"Disable waiting for events on EndDrawing(), automatic events polling
"
	<generated>
	<cdecl: void 'DisableEventWaiting' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawBillboardCamera: camera texture: texture position: position scale: scale tint: tint [
	"Draw a billboard texture
	camera - Camera
	texture - Texture2D
	position - Vector3
	scale - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawBillboard' (RlCamera3D, RlTexture, RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawBillboardProCamera: camera texture: texture source: source position: position up: up size: size origin: origin rotation: rotation tint: tint [
	"Draw a billboard texture defined by source and rotation
	camera - Camera
	texture - Texture2D
	source - Rectangle
	position - Vector3
	up - Vector3
	size - Vector2
	origin - Vector2
	rotation - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawBillboardPro' (RlCamera3D, RlTexture, RlRectangle, RlVector3, RlVector3, RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawBillboardRecCamera: camera texture: texture source: source position: position size: size tint: tint [
	"Draw a billboard texture defined by source
	camera - Camera
	texture - Texture2D
	source - Rectangle
	position - Vector3
	size - Vector2
	tint - Color"
	<generated>
	<cdecl: void 'DrawBillboardRec' (RlCamera3D, RlTexture, RlRectangle, RlVector3, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawBoundingBox: box color: color [
	"Draw bounding box (wires)
	box - BoundingBox
	color - Color"
	<generated>
	<cdecl: void 'DrawBoundingBox' (RlBoundingBox, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCapsuleStartPos: startPos endPos: endPos radius: radius slices: slices rings: rings color: color [
	"Draw a capsule with the center of its sphere caps at startPos and endPos
	startPos - Vector3
	endPos - Vector3
	radius - float
	slices - int
	rings - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCapsule' (RlVector3, RlVector3, float, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCapsuleWiresStartPos: startPos endPos: endPos radius: radius slices: slices rings: rings color: color [
	"Draw capsule wireframe with the center of its sphere caps at startPos and endPos
	startPos - Vector3
	endPos - Vector3
	radius - float
	slices - int
	rings - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCapsuleWires' (RlVector3, RlVector3, float, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircle3DCenter: center radius: radius rotationAxis: rotationAxis rotationAngle: rotationAngle color: color [
	"Draw a circle in 3D world space
	center - Vector3
	radius - float
	rotationAxis - Vector3
	rotationAngle - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCircle3D' (RlVector3, float, RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleCenterX: centerX centerY: centerY radius: radius color: color [
	"Draw a color-filled circle
	centerX - int
	centerY - int
	radius - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCircle' (int32_t, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleGradientCenterX: centerX centerY: centerY radius: radius inner: inner outer: outer [
	"Draw a gradient-filled circle
	centerX - int
	centerY - int
	radius - float
	inner - Color
	outer - Color"
	<generated>
	<cdecl: void 'DrawCircleGradient' (int32_t, int32_t, float, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleLinesCenterX: centerX centerY: centerY radius: radius color: color [
	"Draw circle outline
	centerX - int
	centerY - int
	radius - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCircleLines' (int32_t, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleLinesVCenter: center radius: radius color: color [
	"Draw circle outline (Vector version)
	center - Vector2
	radius - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCircleLinesV' (RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleSectorCenter: center radius: radius startAngle: startAngle endAngle: endAngle segments: segments color: color [
	"Draw a piece of a circle
	center - Vector2
	radius - float
	startAngle - float
	endAngle - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCircleSector' (RlVector2, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleSectorLinesCenter: center radius: radius startAngle: startAngle endAngle: endAngle segments: segments color: color [
	"Draw circle sector outline
	center - Vector2
	radius - float
	startAngle - float
	endAngle - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCircleSectorLines' (RlVector2, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCircleVCenter: center radius: radius color: color [
	"Draw a color-filled circle (Vector version)
	center - Vector2
	radius - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCircleV' (RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCubePosition: position width: width height: height length: length color: color [
	"Draw cube
	position - Vector3
	width - float
	height - float
	length - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCube' (RlVector3, float, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCubeVPosition: position size: size color: color [
	"Draw cube (Vector version)
	position - Vector3
	size - Vector3
	color - Color"
	<generated>
	<cdecl: void 'DrawCubeV' (RlVector3, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCubeWiresPosition: position width: width height: height length: length color: color [
	"Draw cube wires
	position - Vector3
	width - float
	height - float
	length - float
	color - Color"
	<generated>
	<cdecl: void 'DrawCubeWires' (RlVector3, float, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCubeWiresVPosition: position size: size color: color [
	"Draw cube wires (Vector version)
	position - Vector3
	size - Vector3
	color - Color"
	<generated>
	<cdecl: void 'DrawCubeWiresV' (RlVector3, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCylinderExStartPos: startPos endPos: endPos startRadius: startRadius endRadius: endRadius sides: sides color: color [
	"Draw a cylinder with base at startPos and top at endPos
	startPos - Vector3
	endPos - Vector3
	startRadius - float
	endRadius - float
	sides - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCylinderEx' (RlVector3, RlVector3, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCylinderPosition: position radiusTop: radiusTop radiusBottom: radiusBottom height: height slices: slices color: color [
	"Draw a cylinder/cone
	position - Vector3
	radiusTop - float
	radiusBottom - float
	height - float
	slices - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCylinder' (RlVector3, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCylinderWiresExStartPos: startPos endPos: endPos startRadius: startRadius endRadius: endRadius sides: sides color: color [
	"Draw a cylinder wires with base at startPos and top at endPos
	startPos - Vector3
	endPos - Vector3
	startRadius - float
	endRadius - float
	sides - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCylinderWiresEx' (RlVector3, RlVector3, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawCylinderWiresPosition: position radiusTop: radiusTop radiusBottom: radiusBottom height: height slices: slices color: color [
	"Draw a cylinder/cone wires
	position - Vector3
	radiusTop - float
	radiusBottom - float
	height - float
	slices - int
	color - Color"
	<generated>
	<cdecl: void 'DrawCylinderWires' (RlVector3, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawEllipseCenterX: centerX centerY: centerY radiusH: radiusH radiusV: radiusV color: color [
	"Draw ellipse
	centerX - int
	centerY - int
	radiusH - float
	radiusV - float
	color - Color"
	<generated>
	<cdecl: void 'DrawEllipse' (int32_t, int32_t, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawEllipseLinesCenterX: centerX centerY: centerY radiusH: radiusH radiusV: radiusV color: color [
	"Draw ellipse outline
	centerX - int
	centerY - int
	radiusH - float
	radiusV - float
	color - Color"
	<generated>
	<cdecl: void 'DrawEllipseLines' (int32_t, int32_t, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawFPSPosX: posX posY: posY [
	"Draw current FPS
	posX - int
	posY - int"
	<generated>
	<cdecl: void 'DrawFPS' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawGridSlices: slices spacing: spacing [
	"Draw a grid (centered at (0, 0, 0))
	slices - int
	spacing - float"
	<generated>
	<cdecl: void 'DrawGrid' (int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLine3DStartPos: startPos endPos: endPos color: color [
	"Draw a line in 3D world space
	startPos - Vector3
	endPos - Vector3
	color - Color"
	<generated>
	<cdecl: void 'DrawLine3D' (RlVector3, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLineBezierStartPos: startPos endPos: endPos thick: thick color: color [
	"Draw line segment cubic-bezier in-out interpolation
	startPos - Vector2
	endPos - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawLineBezier' (RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLineExStartPos: startPos endPos: endPos thick: thick color: color [
	"Draw a line (using triangles/quads)
	startPos - Vector2
	endPos - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawLineEx' (RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLineStartPosX: startPosX startPosY: startPosY endPosX: endPosX endPosY: endPosY color: color [
	"Draw a line
	startPosX - int
	startPosY - int
	endPosX - int
	endPosY - int
	color - Color"
	<generated>
	<cdecl: void 'DrawLine' (int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLineStripPoints: points pointCount: pointCount color: color [
	"Draw lines sequence (using gl lines)
	points - const Vector2 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'DrawLineStrip' (RlVector2*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawLineVStartPos: startPos endPos: endPos color: color [
	"Draw a line (using gl lines)
	startPos - Vector2
	endPos - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawLineV' (RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawMesh: mesh material: material transform: transform [
	"Draw a 3d mesh with material and transform
	mesh - Mesh
	material - Material
	transform - Matrix"
	<generated>
	<cdecl: void 'DrawMesh' (RlMesh, RlMaterial, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawMeshInstancedMesh: mesh material: material transforms: transforms instances: instances [
	"Draw multiple mesh instances with material and different transforms
	mesh - Mesh
	material - Material
	transforms - const Matrix *
	instances - int"
	<generated>
	<cdecl: void 'DrawMeshInstanced' (RlMesh, RlMaterial, RlMatrix*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModel: model position: position scale: scale tint: tint [
	"Draw a model (with texture if set)
	model - Model
	position - Vector3
	scale - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawModel' (RlModel, RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModelExModel: model position: position rotationAxis: rotationAxis rotationAngle: rotationAngle scale: scale tint: tint [
	"Draw a model with extended parameters
	model - Model
	position - Vector3
	rotationAxis - Vector3
	rotationAngle - float
	scale - Vector3
	tint - Color"
	<generated>
	<cdecl: void 'DrawModelEx' (RlModel, RlVector3, RlVector3, float, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModelPointsExModel: model position: position rotationAxis: rotationAxis rotationAngle: rotationAngle scale: scale tint: tint [
	"Draw a model as points with extended parameters
	model - Model
	position - Vector3
	rotationAxis - Vector3
	rotationAngle - float
	scale - Vector3
	tint - Color"
	<generated>
	<cdecl: void 'DrawModelPointsEx' (RlModel, RlVector3, RlVector3, float, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModelPointsModel: model position: position scale: scale tint: tint [
	"Draw a model as points
	model - Model
	position - Vector3
	scale - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawModelPoints' (RlModel, RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModelWiresExModel: model position: position rotationAxis: rotationAxis rotationAngle: rotationAngle scale: scale tint: tint [
	"Draw a model wires (with texture if set) with extended parameters
	model - Model
	position - Vector3
	rotationAxis - Vector3
	rotationAngle - float
	scale - Vector3
	tint - Color"
	<generated>
	<cdecl: void 'DrawModelWiresEx' (RlModel, RlVector3, RlVector3, float, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawModelWiresModel: model position: position scale: scale tint: tint [
	"Draw a model wires (with texture if set)
	model - Model
	position - Vector3
	scale - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawModelWires' (RlModel, RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPixelPosX: posX posY: posY color: color [
	"Draw a pixel using geometry [Can be slow, use with care]
	posX - int
	posY - int
	color - Color"
	<generated>
	<cdecl: void 'DrawPixel' (int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPixelVPosition: position color: color [
	"Draw a pixel using geometry (Vector version) [Can be slow, use with care]
	position - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawPixelV' (RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPlaneCenterPos: centerPos size: size color: color [
	"Draw a plane XZ
	centerPos - Vector3
	size - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawPlane' (RlVector3, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPoint3DPosition: position color: color [
	"Draw a point in 3D space, actually a small line
	position - Vector3
	color - Color"
	<generated>
	<cdecl: void 'DrawPoint3D' (RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPolyCenter: center sides: sides radius: radius rotation: rotation color: color [
	"Draw a regular polygon (Vector version)
	center - Vector2
	sides - int
	radius - float
	rotation - float
	color - Color"
	<generated>
	<cdecl: void 'DrawPoly' (RlVector2, int32_t, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPolyLinesCenter: center sides: sides radius: radius rotation: rotation color: color [
	"Draw a polygon outline of n sides
	center - Vector2
	sides - int
	radius - float
	rotation - float
	color - Color"
	<generated>
	<cdecl: void 'DrawPolyLines' (RlVector2, int32_t, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawPolyLinesExCenter: center sides: sides radius: radius rotation: rotation lineThick: lineThick color: color [
	"Draw a polygon outline of n sides with extended parameters
	center - Vector2
	sides - int
	radius - float
	rotation - float
	lineThick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawPolyLinesEx' (RlVector2, int32_t, float, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRay: ray color: color [
	"Draw a ray line
	ray - Ray
	color - Color"
	<generated>
	<cdecl: void 'DrawRay' (RlRay, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleGradientExRec: rec topLeft: topLeft bottomLeft: bottomLeft topRight: topRight bottomRight: bottomRight [
	"Draw a gradient-filled rectangle with custom vertex colors
	rec - Rectangle
	topLeft - Color
	bottomLeft - Color
	topRight - Color
	bottomRight - Color"
	<generated>
	<cdecl: void 'DrawRectangleGradientEx' (RlRectangle, RlColor, RlColor, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleGradientHPosX: posX posY: posY width: width height: height left: left right: right [
	"Draw a horizontal-gradient-filled rectangle
	posX - int
	posY - int
	width - int
	height - int
	left - Color
	right - Color"
	<generated>
	<cdecl: void 'DrawRectangleGradientH' (int32_t, int32_t, int32_t, int32_t, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleGradientVPosX: posX posY: posY width: width height: height top: top bottom: bottom [
	"Draw a vertical-gradient-filled rectangle
	posX - int
	posY - int
	width - int
	height - int
	top - Color
	bottom - Color"
	<generated>
	<cdecl: void 'DrawRectangleGradientV' (int32_t, int32_t, int32_t, int32_t, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleLinesExRec: rec lineThick: lineThick color: color [
	"Draw rectangle outline with extended parameters
	rec - Rectangle
	lineThick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleLinesEx' (RlRectangle, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleLinesPosX: posX posY: posY width: width height: height color: color [
	"Draw rectangle outline
	posX - int
	posY - int
	width - int
	height - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleLines' (int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectanglePosX: posX posY: posY width: width height: height color: color [
	"Draw a color-filled rectangle
	posX - int
	posY - int
	width - int
	height - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangle' (int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleProRec: rec origin: origin rotation: rotation color: color [
	"Draw a color-filled rectangle with pro parameters
	rec - Rectangle
	origin - Vector2
	rotation - float
	color - Color"
	<generated>
	<cdecl: void 'DrawRectanglePro' (RlRectangle, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleRec: rec color: color [
	"Draw a color-filled rectangle
	rec - Rectangle
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleRec' (RlRectangle, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleRoundedLinesExRec: rec roundness: roundness segments: segments lineThick: lineThick color: color [
	"Draw rectangle with rounded edges outline
	rec - Rectangle
	roundness - float
	segments - int
	lineThick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleRoundedLinesEx' (RlRectangle, float, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleRoundedLinesRec: rec roundness: roundness segments: segments color: color [
	"Draw rectangle lines with rounded edges
	rec - Rectangle
	roundness - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleRoundedLines' (RlRectangle, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleRoundedRec: rec roundness: roundness segments: segments color: color [
	"Draw rectangle with rounded edges
	rec - Rectangle
	roundness - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleRounded' (RlRectangle, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRectangleVPosition: position size: size color: color [
	"Draw a color-filled rectangle (Vector version)
	position - Vector2
	size - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawRectangleV' (RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRingCenter: center innerRadius: innerRadius outerRadius: outerRadius startAngle: startAngle endAngle: endAngle segments: segments color: color [
	"Draw ring
	center - Vector2
	innerRadius - float
	outerRadius - float
	startAngle - float
	endAngle - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRing' (RlVector2, float, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawRingLinesCenter: center innerRadius: innerRadius outerRadius: outerRadius startAngle: startAngle endAngle: endAngle segments: segments color: color [
	"Draw ring outline
	center - Vector2
	innerRadius - float
	outerRadius - float
	startAngle - float
	endAngle - float
	segments - int
	color - Color"
	<generated>
	<cdecl: void 'DrawRingLines' (RlVector2, float, float, float, float, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSphereCenterPos: centerPos radius: radius color: color [
	"Draw sphere
	centerPos - Vector3
	radius - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSphere' (RlVector3, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSphereExCenterPos: centerPos radius: radius rings: rings slices: slices color: color [
	"Draw sphere with extended parameters
	centerPos - Vector3
	radius - float
	rings - int
	slices - int
	color - Color"
	<generated>
	<cdecl: void 'DrawSphereEx' (RlVector3, float, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSphereWiresCenterPos: centerPos radius: radius rings: rings slices: slices color: color [
	"Draw sphere wires
	centerPos - Vector3
	radius - float
	rings - int
	slices - int
	color - Color"
	<generated>
	<cdecl: void 'DrawSphereWires' (RlVector3, float, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineBasisPoints: points pointCount: pointCount thick: thick color: color [
	"Draw spline: B-Spline, minimum 4 points
	points - const Vector2 *
	pointCount - int
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineBasis' (RlVector2*, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineBezierCubicPoints: points pointCount: pointCount thick: thick color: color [
	"Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
	points - const Vector2 *
	pointCount - int
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineBezierCubic' (RlVector2*, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineBezierQuadraticPoints: points pointCount: pointCount thick: thick color: color [
	"Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
	points - const Vector2 *
	pointCount - int
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineBezierQuadratic' (RlVector2*, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineCatmullRomPoints: points pointCount: pointCount thick: thick color: color [
	"Draw spline: Catmull-Rom, minimum 4 points
	points - const Vector2 *
	pointCount - int
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineCatmullRom' (RlVector2*, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineLinearPoints: points pointCount: pointCount thick: thick color: color [
	"Draw spline: Linear, minimum 2 points
	points - const Vector2 *
	pointCount - int
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineLinear' (RlVector2*, int32_t, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineSegmentBasisP1: p1 p2: p2 p3: p3 p4: p4 thick: thick color: color [
	"Draw spline segment: B-Spline, 4 points
	p1 - Vector2
	p2 - Vector2
	p3 - Vector2
	p4 - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineSegmentBasis' (RlVector2, RlVector2, RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineSegmentBezierCubicP1: p1 c2: c2 c3: c3 p4: p4 thick: thick color: color [
	"Draw spline segment: Cubic Bezier, 2 points, 2 control points
	p1 - Vector2
	c2 - Vector2
	c3 - Vector2
	p4 - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineSegmentBezierCubic' (RlVector2, RlVector2, RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineSegmentBezierQuadraticP1: p1 c2: c2 p3: p3 thick: thick color: color [
	"Draw spline segment: Quadratic Bezier, 2 points, 1 control point
	p1 - Vector2
	c2 - Vector2
	p3 - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineSegmentBezierQuadratic' (RlVector2, RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineSegmentCatmullRomP1: p1 p2: p2 p3: p3 p4: p4 thick: thick color: color [
	"Draw spline segment: Catmull-Rom, 4 points
	p1 - Vector2
	p2 - Vector2
	p3 - Vector2
	p4 - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineSegmentCatmullRom' (RlVector2, RlVector2, RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawSplineSegmentLinearP1: p1 p2: p2 thick: thick color: color [
	"Draw spline segment: Linear, 2 points
	p1 - Vector2
	p2 - Vector2
	thick - float
	color - Color"
	<generated>
	<cdecl: void 'DrawSplineSegmentLinear' (RlVector2, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawText: text posX: posX posY: posY fontSize: fontSize color: color [
	"Draw text (using default font)
	text - const char *
	posX - int
	posY - int
	fontSize - int
	color - Color"
	<generated>
	<cdecl: void 'DrawText' (char8_t*, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextCodepointFont: font codepoint: codepoint position: position fontSize: fontSize tint: tint [
	"Draw one character (codepoint)
	font - Font
	codepoint - int
	position - Vector2
	fontSize - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextCodepoint' (RlFont, int32_t, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextCodepointsFont: font codepoints: codepoints codepointCount: codepointCount position: position fontSize: fontSize spacing: spacing tint: tint [
	"Draw multiple character (codepoint)
	font - Font
	codepoints - const int *
	codepointCount - int
	position - Vector2
	fontSize - float
	spacing - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextCodepoints' (RlFont, int32_t*, int32_t, RlVector2, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextExFont: font text: text position: position fontSize: fontSize spacing: spacing tint: tint [
	"Draw text using font and additional parameters
	font - Font
	text - const char *
	position - Vector2
	fontSize - float
	spacing - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextEx' (RlFont, char8_t*, RlVector2, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextProFont: font text: text position: position origin: origin rotation: rotation fontSize: fontSize spacing: spacing tint: tint [
	"Draw text using Font and pro parameters (rotation)
	font - Font
	text - const char *
	position - Vector2
	origin - Vector2
	rotation - float
	fontSize - float
	spacing - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextPro' (RlFont, char8_t*, RlVector2, RlVector2, float, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTexture: texture posX: posX posY: posY tint: tint [
	"Draw a Texture2D
	texture - Texture2D
	posX - int
	posY - int
	tint - Color"
	<generated>
	<cdecl: void 'DrawTexture' (RlTexture, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextureExTexture: texture position: position rotation: rotation scale: scale tint: tint [
	"Draw a Texture2D with extended parameters
	texture - Texture2D
	position - Vector2
	rotation - float
	scale - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextureEx' (RlTexture, RlVector2, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextureNPatchTexture: texture nPatchInfo: nPatchInfo dest: dest origin: origin rotation: rotation tint: tint [
	"Draws a texture (or part of it) that stretches or shrinks nicely
	texture - Texture2D
	nPatchInfo - NPatchInfo
	dest - Rectangle
	origin - Vector2
	rotation - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextureNPatch' (RlTexture, RlNPatchInfo, RlRectangle, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextureProTexture: texture source: source dest: dest origin: origin rotation: rotation tint: tint [
	"Draw a part of a texture defined by a rectangle with 'pro' parameters
	texture - Texture2D
	source - Rectangle
	dest - Rectangle
	origin - Vector2
	rotation - float
	tint - Color"
	<generated>
	<cdecl: void 'DrawTexturePro' (RlTexture, RlRectangle, RlRectangle, RlVector2, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextureRecTexture: texture source: source position: position tint: tint [
	"Draw a part of a texture defined by a rectangle
	texture - Texture2D
	source - Rectangle
	position - Vector2
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextureRec' (RlTexture, RlRectangle, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTextureVTexture: texture position: position tint: tint [
	"Draw a Texture2D with position defined as Vector2
	texture - Texture2D
	position - Vector2
	tint - Color"
	<generated>
	<cdecl: void 'DrawTextureV' (RlTexture, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangle3DV1: v1 v2: v2 v3: v3 color: color [
	"Draw a color-filled triangle (vertex in counter-clockwise order!)
	v1 - Vector3
	v2 - Vector3
	v3 - Vector3
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangle3D' (RlVector3, RlVector3, RlVector3, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangleFanPoints: points pointCount: pointCount color: color [
	"Draw a triangle fan defined by points (first vertex is the center)
	points - const Vector2 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangleFan' (RlVector2*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangleLinesV1: v1 v2: v2 v3: v3 color: color [
	"Draw triangle outline (vertex in counter-clockwise order!)
	v1 - Vector2
	v2 - Vector2
	v3 - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangleLines' (RlVector2, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangleStrip3DPoints: points pointCount: pointCount color: color [
	"Draw a triangle strip defined by points
	points - const Vector3 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangleStrip3D' (RlVector3*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangleStripPoints: points pointCount: pointCount color: color [
	"Draw a triangle strip defined by points
	points - const Vector2 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangleStrip' (RlVector2*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> drawTriangleV1: v1 v2: v2 v3: v3 color: color [
	"Draw a color-filled triangle (vertex in counter-clockwise order!)
	v1 - Vector2
	v2 - Vector2
	v3 - Vector2
	color - Color"
	<generated>
	<cdecl: void 'DrawTriangle' (RlVector2, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> enableCursor [
	"Enables cursor (unlock cursor)
"
	<generated>
	<cdecl: void 'EnableCursor' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> enableEventWaiting [
	"Enable waiting for events on EndDrawing(), no automatic event polling
"
	<generated>
	<cdecl: void 'EnableEventWaiting' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> encodeDataBase64Data: data dataSize: dataSize outputSize: outputSize [
	"Encode data to Base64 string, memory must be MemFree()
	data - const unsigned char *
	dataSize - int
	outputSize - int *"
	<generated>
	<cdecl: char8_t* 'EncodeDataBase64' (uchar8_t*, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endBlendMode [
	"End blending mode (reset to default: alpha blending)
"
	<generated>
	<cdecl: void 'EndBlendMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endDrawing [
	"End canvas drawing and swap buffers (double buffering)
"
	<generated>
	<cdecl: void 'EndDrawing' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endMode2D [
	"Ends 2D mode with custom camera
"
	<generated>
	<cdecl: void 'EndMode2D' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endMode3D [
	"Ends 3D mode and returns to default 2D orthographic mode
"
	<generated>
	<cdecl: void 'EndMode3D' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endScissorMode [
	"End scissor mode
"
	<generated>
	<cdecl: void 'EndScissorMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endShaderMode [
	"End custom shader drawing (use default shader)
"
	<generated>
	<cdecl: void 'EndShaderMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endTextureMode [
	"Ends drawing to render texture
"
	<generated>
	<cdecl: void 'EndTextureMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> endVrStereoMode [
	"End stereo rendering (requires VR simulator)
"
	<generated>
	<cdecl: void 'EndVrStereoMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportAutomationEventList: list fileName: fileName [
	"Export automation events list as text file
	list - AutomationEventList
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportAutomationEventList' (RlAutomationEventList, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportDataAsCodeData: data dataSize: dataSize fileName: fileName [
	"Export data to code (.h), returns true on success
	data - const unsigned char *
	dataSize - int
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportDataAsCode' (uchar8_t*, int32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportFontAsCodeFont: font fileName: fileName [
	"Export font as code file, returns true on success
	font - Font
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportFontAsCode' (RlFont, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportImage: image fileName: fileName [
	"Export image data to file, returns true on success
	image - Image
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportImage' (RlImage, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportImageAsCodeImage: image fileName: fileName [
	"Export image as code file defining an array of bytes, returns true on success
	image - Image
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportImageAsCode' (RlImage, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportImageToMemoryImage: image fileType: fileType fileSize: fileSize [
	"Export image to memory buffer
	image - Image
	fileType - const char *
	fileSize - int *"
	<generated>
	<cdecl: uchar8_t* 'ExportImageToMemory' (RlImage, char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportMesh: mesh fileName: fileName [
	"Export mesh data to file, returns true on success
	mesh - Mesh
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportMesh' (RlMesh, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportMeshAsCodeMesh: mesh fileName: fileName [
	"Export mesh as code file (.h) defining multiple arrays of vertex attributes
	mesh - Mesh
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportMeshAsCode' (RlMesh, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportWave: wave fileName: fileName [
	"Export wave data to file, returns true on success
	wave - Wave
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportWave' (RlWave, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> exportWaveAsCodeWave: wave fileName: fileName [
	"Export wave sample data to code (.h), returns true on success
	wave - Wave
	fileName - const char *"
	<generated>
	<cdecl: bool 'ExportWaveAsCode' (RlWave, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> fadeColor: color alpha: alpha [
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f
	color - Color
	alpha - float"
	<generated>
	<cdecl: RlColor 'Fade' (RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> fileExistsFileName: fileName [
	"Check if file exists
	fileName - const char *"
	<generated>
	<cdecl: bool 'FileExists' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageCellularWidth: width height: height tileSize: tileSize [
	"Generate image: cellular algorithm, bigger tileSize means bigger cells
	width - int
	height - int
	tileSize - int"
	<generated>
	<cdecl: RlImage 'GenImageCellular' (int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageCheckedWidth: width height: height checksX: checksX checksY: checksY col1: col1 col2: col2 [
	"Generate image: checked
	width - int
	height - int
	checksX - int
	checksY - int
	col1 - Color
	col2 - Color"
	<generated>
	<cdecl: RlImage 'GenImageChecked' (int32_t, int32_t, int32_t, int32_t, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageColorWidth: width height: height color: color [
	"Generate image: plain color
	width - int
	height - int
	color - Color"
	<generated>
	<cdecl: RlImage 'GenImageColor' (int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageFontAtlasGlyphs: glyphs glyphRecs: glyphRecs glyphCount: glyphCount fontSize: fontSize padding: padding packMethod: packMethod [
	"Generate image font atlas using chars info
	glyphs - const GlyphInfo *
	glyphRecs - Rectangle **
	glyphCount - int
	fontSize - int
	padding - int
	packMethod - int"
	<generated>
	<cdecl: RlImage 'GenImageFontAtlas' (RlGlyphInfo*, void*, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageGradientLinearWidth: width height: height direction: direction start: start end: end [
	"Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
	width - int
	height - int
	direction - int
	start - Color
	end - Color"
	<generated>
	<cdecl: RlImage 'GenImageGradientLinear' (int32_t, int32_t, int32_t, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageGradientRadialWidth: width height: height density: density inner: inner outer: outer [
	"Generate image: radial gradient
	width - int
	height - int
	density - float
	inner - Color
	outer - Color"
	<generated>
	<cdecl: RlImage 'GenImageGradientRadial' (int32_t, int32_t, float, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageGradientSquareWidth: width height: height density: density inner: inner outer: outer [
	"Generate image: square gradient
	width - int
	height - int
	density - float
	inner - Color
	outer - Color"
	<generated>
	<cdecl: RlImage 'GenImageGradientSquare' (int32_t, int32_t, float, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImagePerlinNoiseWidth: width height: height offsetX: offsetX offsetY: offsetY scale: scale [
	"Generate image: perlin noise
	width - int
	height - int
	offsetX - int
	offsetY - int
	scale - float"
	<generated>
	<cdecl: RlImage 'GenImagePerlinNoise' (int32_t, int32_t, int32_t, int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageTextWidth: width height: height text: text [
	"Generate image: grayscale image from text data
	width - int
	height - int
	text - const char *"
	<generated>
	<cdecl: RlImage 'GenImageText' (int32_t, int32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genImageWhiteNoiseWidth: width height: height factor: factor [
	"Generate image: white noise
	width - int
	height - int
	factor - float"
	<generated>
	<cdecl: RlImage 'GenImageWhiteNoise' (int32_t, int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshConeRadius: radius height: height slices: slices [
	"Generate cone/pyramid mesh
	radius - float
	height - float
	slices - int"
	<generated>
	<cdecl: RlMesh 'GenMeshCone' (float, float, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshCubeWidth: width height: height length: length [
	"Generate cuboid mesh
	width - float
	height - float
	length - float"
	<generated>
	<cdecl: RlMesh 'GenMeshCube' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshCubicmap: cubicmap cubeSize: cubeSize [
	"Generate cubes-based map mesh from image data
	cubicmap - Image
	cubeSize - Vector3"
	<generated>
	<cdecl: RlMesh 'GenMeshCubicmap' (RlImage, RlVector3)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshCylinderRadius: radius height: height slices: slices [
	"Generate cylinder mesh
	radius - float
	height - float
	slices - int"
	<generated>
	<cdecl: RlMesh 'GenMeshCylinder' (float, float, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshHeightmap: heightmap size: size [
	"Generate heightmap mesh from image data
	heightmap - Image
	size - Vector3"
	<generated>
	<cdecl: RlMesh 'GenMeshHeightmap' (RlImage, RlVector3)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshHemiSphereRadius: radius rings: rings slices: slices [
	"Generate half-sphere mesh (no bottom cap)
	radius - float
	rings - int
	slices - int"
	<generated>
	<cdecl: RlMesh 'GenMeshHemiSphere' (float, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshKnotRadius: radius size: size radSeg: radSeg sides: sides [
	"Generate trefoil knot mesh
	radius - float
	size - float
	radSeg - int
	sides - int"
	<generated>
	<cdecl: RlMesh 'GenMeshKnot' (float, float, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshPlaneWidth: width length: length resX: resX resZ: resZ [
	"Generate plane mesh (with subdivisions)
	width - float
	length - float
	resX - int
	resZ - int"
	<generated>
	<cdecl: RlMesh 'GenMeshPlane' (float, float, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshPolySides: sides radius: radius [
	"Generate polygonal mesh
	sides - int
	radius - float"
	<generated>
	<cdecl: RlMesh 'GenMeshPoly' (int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshSphereRadius: radius rings: rings slices: slices [
	"Generate sphere mesh (standard sphere)
	radius - float
	rings - int
	slices - int"
	<generated>
	<cdecl: RlMesh 'GenMeshSphere' (float, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshTangentsMesh: mesh [
	"Compute mesh tangents
	mesh - Mesh *"
	<generated>
	<cdecl: void 'GenMeshTangents' (RlMesh*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genMeshTorusRadius: radius size: size radSeg: radSeg sides: sides [
	"Generate torus mesh
	radius - float
	size - float
	radSeg - int
	sides - int"
	<generated>
	<cdecl: RlMesh 'GenMeshTorus' (float, float, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> genTextureMipmapsTexture: texture [
	"Generate GPU mipmaps for a texture
	texture - Texture2D *"
	<generated>
	<cdecl: void 'GenTextureMipmaps' (RlTexture*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getApplicationDirectory [
	"Get the directory of the running application (uses static string)
"
	<generated>
	<cdecl: char8_t* 'GetApplicationDirectory' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCameraMatrix2DCamera: camera [
	"Get camera 2d transform matrix
	camera - Camera2D"
	<generated>
	<cdecl: RlMatrix 'GetCameraMatrix2D' (RlCamera2D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCameraMatrixCamera: camera [
	"Get camera transform matrix (view matrix)
	camera - Camera"
	<generated>
	<cdecl: RlMatrix 'GetCameraMatrix' (RlCamera3D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCharPressed [
	"Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
"
	<generated>
	<cdecl: int32_t 'GetCharPressed' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getClipboardImage [
	"Get clipboard image content
"
	<generated>
	<cdecl: RlImage 'GetClipboardImage' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getClipboardText [
	"Get clipboard text content
"
	<generated>
	<cdecl: char8_t* 'GetClipboardText' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCodepointCountText: text [
	"Get total number of codepoints in a UTF-8 encoded string
	text - const char *"
	<generated>
	<cdecl: int32_t 'GetCodepointCount' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCodepointNextText: text codepointSize: codepointSize [
	"Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
	text - const char *
	codepointSize - int *"
	<generated>
	<cdecl: int32_t 'GetCodepointNext' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCodepointPreviousText: text codepointSize: codepointSize [
	"Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
	text - const char *
	codepointSize - int *"
	<generated>
	<cdecl: int32_t 'GetCodepointPrevious' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCodepointText: text codepointSize: codepointSize [
	"Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
	text - const char *
	codepointSize - int *"
	<generated>
	<cdecl: int32_t 'GetCodepoint' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCollisionRecRec1: rec1 rec2: rec2 [
	"Get collision rectangle for two rectangles collision
	rec1 - Rectangle
	rec2 - Rectangle"
	<generated>
	<cdecl: RlRectangle 'GetCollisionRec' (RlRectangle, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getColorHexValue: hexValue [
	"Get Color structure from hexadecimal value
	hexValue - unsigned int"
	<generated>
	<cdecl: RlColor 'GetColor' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getCurrentMonitor [
	"Get current monitor where window is placed
"
	<generated>
	<cdecl: int32_t 'GetCurrentMonitor' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getDirectoryPathFilePath: filePath [
	"Get full path for a given fileName with path (uses static string)
	filePath - const char *"
	<generated>
	<cdecl: char8_t* 'GetDirectoryPath' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFPS [
	"Get current FPS
"
	<generated>
	<cdecl: int32_t 'GetFPS' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFileExtensionFileName: fileName [
	"Get pointer to extension for a filename string (includes dot: '.png')
	fileName - const char *"
	<generated>
	<cdecl: char8_t* 'GetFileExtension' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFileLengthFileName: fileName [
	"Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
	fileName - const char *"
	<generated>
	<cdecl: int32_t 'GetFileLength' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFileModTimeFileName: fileName [
	"Get file modification time (last write time)
	fileName - const char *"
	<generated>
	<cdecl: RlLong 'GetFileModTime' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFileNameFilePath: filePath [
	"Get pointer to filename for a path string
	filePath - const char *"
	<generated>
	<cdecl: char8_t* 'GetFileName' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFileNameWithoutExtFilePath: filePath [
	"Get filename string without extension (uses static string)
	filePath - const char *"
	<generated>
	<cdecl: char8_t* 'GetFileNameWithoutExt' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFontDefault [
	"Get the default Font
"
	<generated>
	<cdecl: RlFont 'GetFontDefault' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getFrameTime [
	"Get time in seconds for last frame drawn (delta time)
"
	<generated>
	<cdecl: float 'GetFrameTime' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGamepadAxisCountGamepad: gamepad [
	"Get gamepad axis count for a gamepad
	gamepad - int"
	<generated>
	<cdecl: int32_t 'GetGamepadAxisCount' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGamepadAxisMovementGamepad: gamepad axis: axis [
	"Get axis movement value for a gamepad axis
	gamepad - int
	axis - int"
	<generated>
	<cdecl: float 'GetGamepadAxisMovement' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGamepadButtonPressed [
	"Get the last gamepad button pressed
"
	<generated>
	<cdecl: int32_t 'GetGamepadButtonPressed' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGamepadNameGamepad: gamepad [
	"Get gamepad internal name id
	gamepad - int"
	<generated>
	<cdecl: char8_t* 'GetGamepadName' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGestureDetected [
	"Get latest detected gesture
"
	<generated>
	<cdecl: int32_t 'GetGestureDetected' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGestureDragAngle [
	"Get gesture drag angle
"
	<generated>
	<cdecl: float 'GetGestureDragAngle' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGestureDragVector [
	"Get gesture drag vector
"
	<generated>
	<cdecl: RlVector2 'GetGestureDragVector' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGestureHoldDuration [
	"Get gesture hold time in seconds
"
	<generated>
	<cdecl: float 'GetGestureHoldDuration' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGesturePinchAngle [
	"Get gesture pinch angle
"
	<generated>
	<cdecl: float 'GetGesturePinchAngle' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGesturePinchVector [
	"Get gesture pinch delta
"
	<generated>
	<cdecl: RlVector2 'GetGesturePinchVector' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGlyphAtlasRecFont: font codepoint: codepoint [
	"Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
	font - Font
	codepoint - int"
	<generated>
	<cdecl: RlRectangle 'GetGlyphAtlasRec' (RlFont, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGlyphIndexFont: font codepoint: codepoint [
	"Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
	font - Font
	codepoint - int"
	<generated>
	<cdecl: int32_t 'GetGlyphIndex' (RlFont, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getGlyphInfoFont: font codepoint: codepoint [
	"Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
	font - Font
	codepoint - int"
	<generated>
	<cdecl: RlGlyphInfo 'GetGlyphInfo' (RlFont, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getImageAlphaBorderImage: image threshold: threshold [
	"Get image alpha border rectangle
	image - Image
	threshold - float"
	<generated>
	<cdecl: RlRectangle 'GetImageAlphaBorder' (RlImage, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getImageColorImage: image x: x y: y [
	"Get image pixel color at (x, y) position
	image - Image
	x - int
	y - int"
	<generated>
	<cdecl: RlColor 'GetImageColor' (RlImage, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getKeyNameKey: key [
	"Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)
	key - int"
	<generated>
	<cdecl: char8_t* 'GetKeyName' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getKeyPressed [
	"Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
"
	<generated>
	<cdecl: int32_t 'GetKeyPressed' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMasterVolume [
	"Get master volume (listener)
"
	<generated>
	<cdecl: float 'GetMasterVolume' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMeshBoundingBoxMesh: mesh [
	"Compute mesh bounding box limits
	mesh - Mesh"
	<generated>
	<cdecl: RlBoundingBox 'GetMeshBoundingBox' (RlMesh)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getModelBoundingBoxModel: model [
	"Compute model bounding box limits (considers all meshes)
	model - Model"
	<generated>
	<cdecl: RlBoundingBox 'GetModelBoundingBox' (RlModel)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorCount [
	"Get number of connected monitors
"
	<generated>
	<cdecl: int32_t 'GetMonitorCount' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorHeightMonitor: monitor [
	"Get specified monitor height (current video mode used by monitor)
	monitor - int"
	<generated>
	<cdecl: int32_t 'GetMonitorHeight' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorNameMonitor: monitor [
	"Get the human-readable, UTF-8 encoded name of the specified monitor
	monitor - int"
	<generated>
	<cdecl: char8_t* 'GetMonitorName' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorPhysicalHeightMonitor: monitor [
	"Get specified monitor physical height in millimetres
	monitor - int"
	<generated>
	<cdecl: int32_t 'GetMonitorPhysicalHeight' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorPhysicalWidthMonitor: monitor [
	"Get specified monitor physical width in millimetres
	monitor - int"
	<generated>
	<cdecl: int32_t 'GetMonitorPhysicalWidth' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorPositionMonitor: monitor [
	"Get specified monitor position
	monitor - int"
	<generated>
	<cdecl: RlVector2 'GetMonitorPosition' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorRefreshRateMonitor: monitor [
	"Get specified monitor refresh rate
	monitor - int"
	<generated>
	<cdecl: int32_t 'GetMonitorRefreshRate' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMonitorWidthMonitor: monitor [
	"Get specified monitor width (current video mode used by monitor)
	monitor - int"
	<generated>
	<cdecl: int32_t 'GetMonitorWidth' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMouseDelta [
	"Get mouse delta between frames
"
	<generated>
	<cdecl: RlVector2 'GetMouseDelta' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMousePosition [
	"Get mouse position XY
"
	<generated>
	<cdecl: RlVector2 'GetMousePosition' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMouseWheelMove [
	"Get mouse wheel movement for X or Y, whichever is larger
"
	<generated>
	<cdecl: float 'GetMouseWheelMove' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMouseWheelMoveV [
	"Get mouse wheel movement for both X and Y
"
	<generated>
	<cdecl: RlVector2 'GetMouseWheelMoveV' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMouseX [
	"Get mouse position X
"
	<generated>
	<cdecl: int32_t 'GetMouseX' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getMouseY [
	"Get mouse position Y
"
	<generated>
	<cdecl: int32_t 'GetMouseY' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getPixelColorSrcPtr: srcPtr format: format [
	"Get Color from a source pixel pointer of certain format
	srcPtr - void *
	format - int"
	<generated>
	<cdecl: RlColor 'GetPixelColor' (void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getPixelDataSizeWidth: width height: height format: format [
	"Get pixel data size in bytes for certain format
	width - int
	height - int
	format - int"
	<generated>
	<cdecl: int32_t 'GetPixelDataSize' (int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getPrevDirectoryPathDirPath: dirPath [
	"Get previous directory path for a given path (uses static string)
	dirPath - const char *"
	<generated>
	<cdecl: char8_t* 'GetPrevDirectoryPath' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRandomValueMin: min max: max [
	"Get a random value between min and max (both included)
	min - int
	max - int"
	<generated>
	<cdecl: int32_t 'GetRandomValue' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRayCollisionBoxRay: ray box: box [
	"Get collision info between ray and box
	ray - Ray
	box - BoundingBox"
	<generated>
	<cdecl: RlRayCollision 'GetRayCollisionBox' (RlRay, RlBoundingBox)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRayCollisionMeshRay: ray mesh: mesh transform: transform [
	"Get collision info between ray and mesh
	ray - Ray
	mesh - Mesh
	transform - Matrix"
	<generated>
	<cdecl: RlRayCollision 'GetRayCollisionMesh' (RlRay, RlMesh, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRayCollisionQuadRay: ray p1: p1 p2: p2 p3: p3 p4: p4 [
	"Get collision info between ray and quad
	ray - Ray
	p1 - Vector3
	p2 - Vector3
	p3 - Vector3
	p4 - Vector3"
	<generated>
	<cdecl: RlRayCollision 'GetRayCollisionQuad' (RlRay, RlVector3, RlVector3, RlVector3, RlVector3)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRayCollisionSphereRay: ray center: center radius: radius [
	"Get collision info between ray and sphere
	ray - Ray
	center - Vector3
	radius - float"
	<generated>
	<cdecl: RlRayCollision 'GetRayCollisionSphere' (RlRay, RlVector3, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRayCollisionTriangleRay: ray p1: p1 p2: p2 p3: p3 [
	"Get collision info between ray and triangle
	ray - Ray
	p1 - Vector3
	p2 - Vector3
	p3 - Vector3"
	<generated>
	<cdecl: RlRayCollision 'GetRayCollisionTriangle' (RlRay, RlVector3, RlVector3, RlVector3)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRenderHeight [
	"Get current render height (it considers HiDPI)
"
	<generated>
	<cdecl: int32_t 'GetRenderHeight' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getRenderWidth [
	"Get current render width (it considers HiDPI)
"
	<generated>
	<cdecl: int32_t 'GetRenderWidth' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getScreenHeight [
	"Get current screen height
"
	<generated>
	<cdecl: int32_t 'GetScreenHeight' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getScreenToWorld2DPosition: position camera: camera [
	"Get the world space position for a 2d camera screen space position
	position - Vector2
	camera - Camera2D"
	<generated>
	<cdecl: RlVector2 'GetScreenToWorld2D' (RlVector2, RlCamera2D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getScreenToWorldRayExPosition: position camera: camera width: width height: height [
	"Get a ray trace from screen position (i.e mouse) in a viewport
	position - Vector2
	camera - Camera
	width - int
	height - int"
	<generated>
	<cdecl: RlRay 'GetScreenToWorldRayEx' (RlVector2, RlCamera3D, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getScreenToWorldRayPosition: position camera: camera [
	"Get a ray trace from screen position (i.e mouse)
	position - Vector2
	camera - Camera"
	<generated>
	<cdecl: RlRay 'GetScreenToWorldRay' (RlVector2, RlCamera3D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getScreenWidth [
	"Get current screen width
"
	<generated>
	<cdecl: int32_t 'GetScreenWidth' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getShaderLocationAttribShader: shader attribName: attribName [
	"Get shader attribute location
	shader - Shader
	attribName - const char *"
	<generated>
	<cdecl: int32_t 'GetShaderLocationAttrib' (RlShader, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getShaderLocationShader: shader uniformName: uniformName [
	"Get shader uniform location
	shader - Shader
	uniformName - const char *"
	<generated>
	<cdecl: int32_t 'GetShaderLocation' (RlShader, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getShapesTexture [
	"Get texture that is used for shapes drawing
"
	<generated>
	<cdecl: RlTexture 'GetShapesTexture' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getShapesTextureRectangle [
	"Get texture source rectangle that is used for shapes drawing
"
	<generated>
	<cdecl: RlRectangle 'GetShapesTextureRectangle' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getSplinePointBasisP1: p1 p2: p2 p3: p3 p4: p4 t: t [
	"Get (evaluate) spline point: B-Spline
	p1 - Vector2
	p2 - Vector2
	p3 - Vector2
	p4 - Vector2
	t - float"
	<generated>
	<cdecl: RlVector2 'GetSplinePointBasis' (RlVector2, RlVector2, RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getSplinePointBezierCubicP1: p1 c2: c2 c3: c3 p4: p4 t: t [
	"Get (evaluate) spline point: Cubic Bezier
	p1 - Vector2
	c2 - Vector2
	c3 - Vector2
	p4 - Vector2
	t - float"
	<generated>
	<cdecl: RlVector2 'GetSplinePointBezierCubic' (RlVector2, RlVector2, RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getSplinePointBezierQuadP1: p1 c2: c2 p3: p3 t: t [
	"Get (evaluate) spline point: Quadratic Bezier
	p1 - Vector2
	c2 - Vector2
	p3 - Vector2
	t - float"
	<generated>
	<cdecl: RlVector2 'GetSplinePointBezierQuad' (RlVector2, RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getSplinePointCatmullRomP1: p1 p2: p2 p3: p3 p4: p4 t: t [
	"Get (evaluate) spline point: Catmull-Rom
	p1 - Vector2
	p2 - Vector2
	p3 - Vector2
	p4 - Vector2
	t - float"
	<generated>
	<cdecl: RlVector2 'GetSplinePointCatmullRom' (RlVector2, RlVector2, RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getSplinePointLinearStartPos: startPos endPos: endPos t: t [
	"Get (evaluate) spline point: Linear
	startPos - Vector2
	endPos - Vector2
	t - float"
	<generated>
	<cdecl: RlVector2 'GetSplinePointLinear' (RlVector2, RlVector2, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTime [
	"Get elapsed time in seconds since InitWindow()
"
	<generated>
	<cdecl: double 'GetTime' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTouchPointCount [
	"Get number of touch points
"
	<generated>
	<cdecl: int32_t 'GetTouchPointCount' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTouchPointIdIndex: index [
	"Get touch point identifier for given index
	index - int"
	<generated>
	<cdecl: int32_t 'GetTouchPointId' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTouchPositionIndex: index [
	"Get touch position XY for a touch point index (relative to screen size)
	index - int"
	<generated>
	<cdecl: RlVector2 'GetTouchPosition' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTouchX [
	"Get touch position X for touch point 0 (relative to screen size)
"
	<generated>
	<cdecl: int32_t 'GetTouchX' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getTouchY [
	"Get touch position Y for touch point 0 (relative to screen size)
"
	<generated>
	<cdecl: int32_t 'GetTouchY' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWindowHandle [
	"Get native window handle
"
	<generated>
	<cdecl: void* 'GetWindowHandle' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWindowPosition [
	"Get window position XY on monitor
"
	<generated>
	<cdecl: RlVector2 'GetWindowPosition' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWindowScaleDPI [
	"Get window scale DPI factor
"
	<generated>
	<cdecl: RlVector2 'GetWindowScaleDPI' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWorkingDirectory [
	"Get current working directory (uses static string)
"
	<generated>
	<cdecl: char8_t* 'GetWorkingDirectory' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWorldToScreen2DPosition: position camera: camera [
	"Get the screen space position for a 2d camera world space position
	position - Vector2
	camera - Camera2D"
	<generated>
	<cdecl: RlVector2 'GetWorldToScreen2D' (RlVector2, RlCamera2D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWorldToScreenExPosition: position camera: camera width: width height: height [
	"Get size position for a 3d world space position
	position - Vector3
	camera - Camera
	width - int
	height - int"
	<generated>
	<cdecl: RlVector2 'GetWorldToScreenEx' (RlVector3, RlCamera3D, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> getWorldToScreenPosition: position camera: camera [
	"Get the screen space position for a 3d world space position
	position - Vector3
	camera - Camera"
	<generated>
	<cdecl: RlVector2 'GetWorldToScreen' (RlVector3, RlCamera3D)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> hideCursor [
	"Hides cursor
"
	<generated>
	<cdecl: void 'HideCursor' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageAlphaClearImage: image color: color threshold: threshold [
	"Clear alpha channel to desired color
	image - Image *
	color - Color
	threshold - float"
	<generated>
	<cdecl: void 'ImageAlphaClear' (RlImage*, RlColor, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageAlphaCropImage: image threshold: threshold [
	"Crop image depending on alpha value
	image - Image *
	threshold - float"
	<generated>
	<cdecl: void 'ImageAlphaCrop' (RlImage*, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageAlphaMaskImage: image alphaMask: alphaMask [
	"Apply alpha mask to image
	image - Image *
	alphaMask - Image"
	<generated>
	<cdecl: void 'ImageAlphaMask' (RlImage*, RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageAlphaPremultiplyImage: image [
	"Premultiply alpha channel
	image - Image *"
	<generated>
	<cdecl: void 'ImageAlphaPremultiply' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageBlurGaussianImage: image blurSize: blurSize [
	"Apply Gaussian blur using a box blur approximation
	image - Image *
	blurSize - int"
	<generated>
	<cdecl: void 'ImageBlurGaussian' (RlImage*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageClearBackgroundDst: dst color: color [
	"Clear image background with given color
	dst - Image *
	color - Color"
	<generated>
	<cdecl: void 'ImageClearBackground' (RlImage*, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorBrightnessImage: image brightness: brightness [
	"Modify image color: brightness (-255 to 255)
	image - Image *
	brightness - int"
	<generated>
	<cdecl: void 'ImageColorBrightness' (RlImage*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorContrastImage: image contrast: contrast [
	"Modify image color: contrast (-100 to 100)
	image - Image *
	contrast - float"
	<generated>
	<cdecl: void 'ImageColorContrast' (RlImage*, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorGrayscaleImage: image [
	"Modify image color: grayscale
	image - Image *"
	<generated>
	<cdecl: void 'ImageColorGrayscale' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorInvertImage: image [
	"Modify image color: invert
	image - Image *"
	<generated>
	<cdecl: void 'ImageColorInvert' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorReplaceImage: image color: color replace: replace [
	"Modify image color: replace color
	image - Image *
	color - Color
	replace - Color"
	<generated>
	<cdecl: void 'ImageColorReplace' (RlImage*, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageColorTintImage: image color: color [
	"Modify image color: tint
	image - Image *
	color - Color"
	<generated>
	<cdecl: void 'ImageColorTint' (RlImage*, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageCopyImage: image [
	"Create an image duplicate (useful for transformations)
	image - Image"
	<generated>
	<cdecl: RlImage 'ImageCopy' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageCropImage: image crop: crop [
	"Crop an image to a defined rectangle
	image - Image *
	crop - Rectangle"
	<generated>
	<cdecl: void 'ImageCrop' (RlImage*, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDitherImage: image rBpp: rBpp gBpp: gBpp bBpp: bBpp aBpp: aBpp [
	"Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
	image - Image *
	rBpp - int
	gBpp - int
	bBpp - int
	aBpp - int"
	<generated>
	<cdecl: void 'ImageDither' (RlImage*, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawCircleDst: dst centerX: centerX centerY: centerY radius: radius color: color [
	"Draw a filled circle within an image
	dst - Image *
	centerX - int
	centerY - int
	radius - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawCircle' (RlImage*, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawCircleLinesDst: dst centerX: centerX centerY: centerY radius: radius color: color [
	"Draw circle outline within an image
	dst - Image *
	centerX - int
	centerY - int
	radius - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawCircleLines' (RlImage*, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawCircleLinesVDst: dst center: center radius: radius color: color [
	"Draw circle outline within an image (Vector version)
	dst - Image *
	center - Vector2
	radius - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawCircleLinesV' (RlImage*, RlVector2, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawCircleVDst: dst center: center radius: radius color: color [
	"Draw a filled circle within an image (Vector version)
	dst - Image *
	center - Vector2
	radius - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawCircleV' (RlImage*, RlVector2, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawDst: dst src: src srcRec: srcRec dstRec: dstRec tint: tint [
	"Draw a source image within a destination image (tint applied to source)
	dst - Image *
	src - Image
	srcRec - Rectangle
	dstRec - Rectangle
	tint - Color"
	<generated>
	<cdecl: void 'ImageDraw' (RlImage*, RlImage, RlRectangle, RlRectangle, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawLineDst: dst startPosX: startPosX startPosY: startPosY endPosX: endPosX endPosY: endPosY color: color [
	"Draw line within an image
	dst - Image *
	startPosX - int
	startPosY - int
	endPosX - int
	endPosY - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawLine' (RlImage*, int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawLineExDst: dst start: start end: end thick: thick color: color [
	"Draw a line defining thickness within an image
	dst - Image *
	start - Vector2
	end - Vector2
	thick - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawLineEx' (RlImage*, RlVector2, RlVector2, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawLineVDst: dst start: start end: end color: color [
	"Draw line within an image (Vector version)
	dst - Image *
	start - Vector2
	end - Vector2
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawLineV' (RlImage*, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawPixelDst: dst posX: posX posY: posY color: color [
	"Draw pixel within an image
	dst - Image *
	posX - int
	posY - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawPixel' (RlImage*, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawPixelVDst: dst position: position color: color [
	"Draw pixel within an image (Vector version)
	dst - Image *
	position - Vector2
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawPixelV' (RlImage*, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawRectangleDst: dst posX: posX posY: posY width: width height: height color: color [
	"Draw rectangle within an image
	dst - Image *
	posX - int
	posY - int
	width - int
	height - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawRectangle' (RlImage*, int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawRectangleLinesDst: dst rec: rec thick: thick color: color [
	"Draw rectangle lines within an image
	dst - Image *
	rec - Rectangle
	thick - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawRectangleLines' (RlImage*, RlRectangle, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawRectangleRecDst: dst rec: rec color: color [
	"Draw rectangle within an image
	dst - Image *
	rec - Rectangle
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawRectangleRec' (RlImage*, RlRectangle, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawRectangleVDst: dst position: position size: size color: color [
	"Draw rectangle within an image (Vector version)
	dst - Image *
	position - Vector2
	size - Vector2
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawRectangleV' (RlImage*, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTextDst: dst text: text posX: posX posY: posY fontSize: fontSize color: color [
	"Draw text (using default font) within an image (destination)
	dst - Image *
	text - const char *
	posX - int
	posY - int
	fontSize - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawText' (RlImage*, char8_t*, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTextExDst: dst font: font text: text position: position fontSize: fontSize spacing: spacing tint: tint [
	"Draw text (custom sprite font) within an image (destination)
	dst - Image *
	font - Font
	text - const char *
	position - Vector2
	fontSize - float
	spacing - float
	tint - Color"
	<generated>
	<cdecl: void 'ImageDrawTextEx' (RlImage*, RlFont, char8_t*, RlVector2, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTriangleDst: dst v1: v1 v2: v2 v3: v3 color: color [
	"Draw triangle within an image
	dst - Image *
	v1 - Vector2
	v2 - Vector2
	v3 - Vector2
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawTriangle' (RlImage*, RlVector2, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTriangleExDst: dst v1: v1 v2: v2 v3: v3 c1: c1 c2: c2 c3: c3 [
	"Draw triangle with interpolated colors within an image
	dst - Image *
	v1 - Vector2
	v2 - Vector2
	v3 - Vector2
	c1 - Color
	c2 - Color
	c3 - Color"
	<generated>
	<cdecl: void 'ImageDrawTriangleEx' (RlImage*, RlVector2, RlVector2, RlVector2, RlColor, RlColor, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTriangleFanDst: dst points: points pointCount: pointCount color: color [
	"Draw a triangle fan defined by points within an image (first vertex is the center)
	dst - Image *
	points - Vector2 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawTriangleFan' (RlImage*, RlVector2*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTriangleLinesDst: dst v1: v1 v2: v2 v3: v3 color: color [
	"Draw triangle outline within an image
	dst - Image *
	v1 - Vector2
	v2 - Vector2
	v3 - Vector2
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawTriangleLines' (RlImage*, RlVector2, RlVector2, RlVector2, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageDrawTriangleStripDst: dst points: points pointCount: pointCount color: color [
	"Draw a triangle strip defined by points within an image
	dst - Image *
	points - Vector2 *
	pointCount - int
	color - Color"
	<generated>
	<cdecl: void 'ImageDrawTriangleStrip' (RlImage*, RlVector2*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageFlipHorizontalImage: image [
	"Flip image horizontally
	image - Image *"
	<generated>
	<cdecl: void 'ImageFlipHorizontal' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageFlipVerticalImage: image [
	"Flip image vertically
	image - Image *"
	<generated>
	<cdecl: void 'ImageFlipVertical' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageFormatImage: image newFormat: newFormat [
	"Convert image data to desired format
	image - Image *
	newFormat - int"
	<generated>
	<cdecl: void 'ImageFormat' (RlImage*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageFromChannelImage: image selectedChannel: selectedChannel [
	"Create an image from a selected channel of another image (GRAYSCALE)
	image - Image
	selectedChannel - int"
	<generated>
	<cdecl: RlImage 'ImageFromChannel' (RlImage, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageFromImage: image rec: rec [
	"Create an image from another image piece
	image - Image
	rec - Rectangle"
	<generated>
	<cdecl: RlImage 'ImageFromImage' (RlImage, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageKernelConvolutionImage: image kernel: kernel kernelSize: kernelSize [
	"Apply custom square convolution kernel to image
	image - Image *
	kernel - const float *
	kernelSize - int"
	<generated>
	<cdecl: void 'ImageKernelConvolution' (RlImage*, float*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageMipmapsImage: image [
	"Compute all mipmap levels for a provided image
	image - Image *"
	<generated>
	<cdecl: void 'ImageMipmaps' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageResizeCanvasImage: image newWidth: newWidth newHeight: newHeight offsetX: offsetX offsetY: offsetY fill: fill [
	"Resize canvas and fill with color
	image - Image *
	newWidth - int
	newHeight - int
	offsetX - int
	offsetY - int
	fill - Color"
	<generated>
	<cdecl: void 'ImageResizeCanvas' (RlImage*, int32_t, int32_t, int32_t, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageResizeImage: image newWidth: newWidth newHeight: newHeight [
	"Resize image (Bicubic scaling algorithm)
	image - Image *
	newWidth - int
	newHeight - int"
	<generated>
	<cdecl: void 'ImageResize' (RlImage*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageResizeNNImage: image newWidth: newWidth newHeight: newHeight [
	"Resize image (Nearest-Neighbor scaling algorithm)
	image - Image *
	newWidth - int
	newHeight - int"
	<generated>
	<cdecl: void 'ImageResizeNN' (RlImage*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageRotateCCWImage: image [
	"Rotate image counter-clockwise 90deg
	image - Image *"
	<generated>
	<cdecl: void 'ImageRotateCCW' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageRotateCWImage: image [
	"Rotate image clockwise 90deg
	image - Image *"
	<generated>
	<cdecl: void 'ImageRotateCW' (RlImage*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageRotateImage: image degrees: degrees [
	"Rotate image by input angle in degrees (-359 to 359)
	image - Image *
	degrees - int"
	<generated>
	<cdecl: void 'ImageRotate' (RlImage*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageText: text fontSize: fontSize color: color [
	"Create an image from text (default font)
	text - const char *
	fontSize - int
	color - Color"
	<generated>
	<cdecl: RlImage 'ImageText' (char8_t*, int32_t, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageTextExFont: font text: text fontSize: fontSize spacing: spacing tint: tint [
	"Create an image from text (custom sprite font)
	font - Font
	text - const char *
	fontSize - float
	spacing - float
	tint - Color"
	<generated>
	<cdecl: RlImage 'ImageTextEx' (RlFont, char8_t*, float, float, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> imageToPOTImage: image fill: fill [
	"Convert image to POT (power-of-two)
	image - Image *
	fill - Color"
	<generated>
	<cdecl: void 'ImageToPOT' (RlImage*, RlColor)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> initWindowWidth: width height: height title: title [
	"Initialize window and OpenGL context
	width - int
	height - int
	title - const char *"
	<generated>
	<cdecl: void 'InitWindow' (int32_t, int32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isCursorHidden [
	"Check if cursor is not visible
"
	<generated>
	<cdecl: bool 'IsCursorHidden' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isCursorOnScreen [
	"Check if cursor is on the screen
"
	<generated>
	<cdecl: bool 'IsCursorOnScreen' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isFileDropped [
	"Check if a file has been dropped into window
"
	<generated>
	<cdecl: bool 'IsFileDropped' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isFileExtensionFileName: fileName ext: ext [
	"Check file extension (including point: .png, .wav)
	fileName - const char *
	ext - const char *"
	<generated>
	<cdecl: bool 'IsFileExtension' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isFileNameValidFileName: fileName [
	"Check if fileName is valid for the platform/OS
	fileName - const char *"
	<generated>
	<cdecl: bool 'IsFileNameValid' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isFontValidFont: font [
	"Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
	font - Font"
	<generated>
	<cdecl: bool 'IsFontValid' (RlFont)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGamepadAvailableGamepad: gamepad [
	"Check if a gamepad is available
	gamepad - int"
	<generated>
	<cdecl: bool 'IsGamepadAvailable' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGamepadButtonDownGamepad: gamepad button: button [
	"Check if a gamepad button is being pressed
	gamepad - int
	button - int"
	<generated>
	<cdecl: bool 'IsGamepadButtonDown' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGamepadButtonPressedGamepad: gamepad button: button [
	"Check if a gamepad button has been pressed once
	gamepad - int
	button - int"
	<generated>
	<cdecl: bool 'IsGamepadButtonPressed' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGamepadButtonReleasedGamepad: gamepad button: button [
	"Check if a gamepad button has been released once
	gamepad - int
	button - int"
	<generated>
	<cdecl: bool 'IsGamepadButtonReleased' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGamepadButtonUpGamepad: gamepad button: button [
	"Check if a gamepad button is NOT being pressed
	gamepad - int
	button - int"
	<generated>
	<cdecl: bool 'IsGamepadButtonUp' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isGestureDetectedGesture: gesture [
	"Check if a gesture have been detected
	gesture - unsigned int"
	<generated>
	<cdecl: bool 'IsGestureDetected' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isImageValidImage: image [
	"Check if an image is valid (data and parameters)
	image - Image"
	<generated>
	<cdecl: bool 'IsImageValid' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isKeyDownKey: key [
	"Check if a key is being pressed
	key - int"
	<generated>
	<cdecl: bool 'IsKeyDown' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isKeyPressedKey: key [
	"Check if a key has been pressed once
	key - int"
	<generated>
	<cdecl: bool 'IsKeyPressed' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isKeyPressedRepeatKey: key [
	"Check if a key has been pressed again
	key - int"
	<generated>
	<cdecl: bool 'IsKeyPressedRepeat' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isKeyReleasedKey: key [
	"Check if a key has been released once
	key - int"
	<generated>
	<cdecl: bool 'IsKeyReleased' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isKeyUpKey: key [
	"Check if a key is NOT being pressed
	key - int"
	<generated>
	<cdecl: bool 'IsKeyUp' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isMaterialValidMaterial: material [
	"Check if a material is valid (shader assigned, map textures loaded in GPU)
	material - Material"
	<generated>
	<cdecl: bool 'IsMaterialValid' (RlMaterial)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isModelAnimationValidModel: model anim: anim [
	"Check model animation skeleton match
	model - Model
	anim - ModelAnimation"
	<generated>
	<cdecl: bool 'IsModelAnimationValid' (RlModel, RlModelAnimation)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isModelValidModel: model [
	"Check if a model is valid (loaded in GPU, VAO/VBOs)
	model - Model"
	<generated>
	<cdecl: bool 'IsModelValid' (RlModel)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isMouseButtonDownButton: button [
	"Check if a mouse button is being pressed
	button - int"
	<generated>
	<cdecl: bool 'IsMouseButtonDown' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isMouseButtonPressedButton: button [
	"Check if a mouse button has been pressed once
	button - int"
	<generated>
	<cdecl: bool 'IsMouseButtonPressed' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isMouseButtonReleasedButton: button [
	"Check if a mouse button has been released once
	button - int"
	<generated>
	<cdecl: bool 'IsMouseButtonReleased' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isMouseButtonUpButton: button [
	"Check if a mouse button is NOT being pressed
	button - int"
	<generated>
	<cdecl: bool 'IsMouseButtonUp' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isPathFilePath: path [
	"Check if a given path is a file or a directory
	path - const char *"
	<generated>
	<cdecl: bool 'IsPathFile' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isRenderTextureValidTarget: target [
	"Check if a render texture is valid (loaded in GPU)
	target - RenderTexture2D"
	<generated>
	<cdecl: bool 'IsRenderTextureValid' (RlRenderTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isShaderValidShader: shader [
	"Check if a shader is valid (loaded on GPU)
	shader - Shader"
	<generated>
	<cdecl: bool 'IsShaderValid' (RlShader)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isTextureValidTexture: texture [
	"Check if a texture is valid (loaded in GPU)
	texture - Texture2D"
	<generated>
	<cdecl: bool 'IsTextureValid' (RlTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWaveValidWave: wave [
	"Checks if wave data is valid (data loaded and parameters)
	wave - Wave"
	<generated>
	<cdecl: bool 'IsWaveValid' (RlWave)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowFocused [
	"Check if window is currently focused
"
	<generated>
	<cdecl: bool 'IsWindowFocused' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowFullscreen [
	"Check if window is currently fullscreen
"
	<generated>
	<cdecl: bool 'IsWindowFullscreen' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowHidden [
	"Check if window is currently hidden
"
	<generated>
	<cdecl: bool 'IsWindowHidden' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowMaximized [
	"Check if window is currently maximized
"
	<generated>
	<cdecl: bool 'IsWindowMaximized' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowMinimized [
	"Check if window is currently minimized
"
	<generated>
	<cdecl: bool 'IsWindowMinimized' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowReady [
	"Check if window has been initialized successfully
"
	<generated>
	<cdecl: bool 'IsWindowReady' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowResized [
	"Check if window has been resized last frame
"
	<generated>
	<cdecl: bool 'IsWindowResized' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> isWindowStateFlag: flag [
	"Check if one specific window flag is enabled
	flag - unsigned int"
	<generated>
	<cdecl: bool 'IsWindowState' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadAutomationEventListFileName: fileName [
	"Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
	fileName - const char *"
	<generated>
	<cdecl: RlAutomationEventList 'LoadAutomationEventList' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadCodepointsText: text count: count [
	"Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
	text - const char *
	count - int *"
	<generated>
	<cdecl: int32_t* 'LoadCodepoints' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadDirectoryFilesDirPath: dirPath [
	"Load directory filepaths
	dirPath - const char *"
	<generated>
	<cdecl: RlFilePathList 'LoadDirectoryFiles' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadDirectoryFilesExBasePath: basePath filter: filter scanSubdirs: scanSubdirs [
	"Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
	basePath - const char *
	filter - const char *
	scanSubdirs - bool"
	<generated>
	<cdecl: RlFilePathList 'LoadDirectoryFilesEx' (char8_t*, char8_t*, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadDroppedFiles [
	"Load dropped filepaths
"
	<generated>
	<cdecl: RlFilePathList 'LoadDroppedFiles' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFileDataFileName: fileName dataSize: dataSize [
	"Load file data as byte array (read)
	fileName - const char *
	dataSize - int *"
	<generated>
	<cdecl: uchar8_t* 'LoadFileData' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFileTextFileName: fileName [
	"Load text data from file (read), returns a '\0' terminated string
	fileName - const char *"
	<generated>
	<cdecl: char8_t* 'LoadFileText' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFontDataFileData: fileData dataSize: dataSize fontSize: fontSize codepoints: codepoints codepointCount: codepointCount type: type [
	"Load font data for further use
	fileData - const unsigned char *
	dataSize - int
	fontSize - int
	codepoints - int *
	codepointCount - int
	type - int"
	<generated>
	<cdecl: RlGlyphInfo* 'LoadFontData' (uchar8_t*, int32_t, int32_t, int32_t*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFontExFileName: fileName fontSize: fontSize codepoints: codepoints codepointCount: codepointCount [
	"Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
	fileName - const char *
	fontSize - int
	codepoints - int *
	codepointCount - int"
	<generated>
	<cdecl: RlFont 'LoadFontEx' (char8_t*, int32_t, int32_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFontFileName: fileName [
	"Load font from file into GPU memory (VRAM)
	fileName - const char *"
	<generated>
	<cdecl: RlFont 'LoadFont' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFontFromImage: image key: key firstChar: firstChar [
	"Load font from Image (XNA style)
	image - Image
	key - Color
	firstChar - int"
	<generated>
	<cdecl: RlFont 'LoadFontFromImage' (RlImage, RlColor, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadFontFromMemoryFileType: fileType fileData: fileData dataSize: dataSize fontSize: fontSize codepoints: codepoints codepointCount: codepointCount [
	"Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
	fileType - const char *
	fileData - const unsigned char *
	dataSize - int
	fontSize - int
	codepoints - int *
	codepointCount - int"
	<generated>
	<cdecl: RlFont 'LoadFontFromMemory' (char8_t*, uchar8_t*, int32_t, int32_t, int32_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageAnimFileName: fileName frames: frames [
	"Load image sequence from file (frames appended to image.data)
	fileName - const char *
	frames - int *"
	<generated>
	<cdecl: RlImage 'LoadImageAnim' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageAnimFromMemoryFileType: fileType fileData: fileData dataSize: dataSize frames: frames [
	"Load image sequence from memory buffer
	fileType - const char *
	fileData - const unsigned char *
	dataSize - int
	frames - int *"
	<generated>
	<cdecl: RlImage 'LoadImageAnimFromMemory' (char8_t*, uchar8_t*, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageColorsImage: image [
	"Load color data from image as a Color array (RGBA - 32bit)
	image - Image"
	<generated>
	<cdecl: RlColor* 'LoadImageColors' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageFileName: fileName [
	"Load image from file into CPU memory (RAM)
	fileName - const char *"
	<generated>
	<cdecl: RlImage 'LoadImage' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageFromMemoryFileType: fileType fileData: fileData dataSize: dataSize [
	"Load image from memory buffer, fileType refers to extension: i.e. '.png'
	fileType - const char *
	fileData - const unsigned char *
	dataSize - int"
	<generated>
	<cdecl: RlImage 'LoadImageFromMemory' (char8_t*, uchar8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageFromScreen [
	"Load image from screen buffer and (screenshot)
"
	<generated>
	<cdecl: RlImage 'LoadImageFromScreen' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageFromTexture: texture [
	"Load image from GPU texture data
	texture - Texture2D"
	<generated>
	<cdecl: RlImage 'LoadImageFromTexture' (RlTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImagePaletteImage: image maxPaletteSize: maxPaletteSize colorCount: colorCount [
	"Load colors palette from image as a Color array (RGBA - 32bit)
	image - Image
	maxPaletteSize - int
	colorCount - int *"
	<generated>
	<cdecl: RlColor* 'LoadImagePalette' (RlImage, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadImageRawFileName: fileName width: width height: height format: format headerSize: headerSize [
	"Load image from RAW file data
	fileName - const char *
	width - int
	height - int
	format - int
	headerSize - int"
	<generated>
	<cdecl: RlImage 'LoadImageRaw' (char8_t*, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadMaterialDefault [
	"Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
"
	<generated>
	<cdecl: RlMaterial 'LoadMaterialDefault' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadMaterialsFileName: fileName materialCount: materialCount [
	"Load materials from model file
	fileName - const char *
	materialCount - int *"
	<generated>
	<cdecl: RlMaterial* 'LoadMaterials' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadModelAnimationsFileName: fileName animCount: animCount [
	"Load model animations from file
	fileName - const char *
	animCount - int *"
	<generated>
	<cdecl: RlModelAnimation* 'LoadModelAnimations' (char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadModelFileName: fileName [
	"Load model from files (meshes and materials)
	fileName - const char *"
	<generated>
	<cdecl: RlModel 'LoadModel' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadModelFromMesh: mesh [
	"Load model from generated mesh (default material)
	mesh - Mesh"
	<generated>
	<cdecl: RlModel 'LoadModelFromMesh' (RlMesh)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadRandomSequenceCount: count min: min max: max [
	"Load random values sequence, no values repeated
	count - unsigned int
	min - int
	max - int"
	<generated>
	<cdecl: int32_t* 'LoadRandomSequence' (uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadRenderTextureWidth: width height: height [
	"Load texture for rendering (framebuffer)
	width - int
	height - int"
	<generated>
	<cdecl: RlRenderTexture 'LoadRenderTexture' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadShaderFromMemoryVsCode: vsCode fsCode: fsCode [
	"Load shader from code strings and bind default locations
	vsCode - const char *
	fsCode - const char *"
	<generated>
	<cdecl: RlShader 'LoadShaderFromMemory' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadShaderVsFileName: vsFileName fsFileName: fsFileName [
	"Load shader from files and bind default locations
	vsFileName - const char *
	fsFileName - const char *"
	<generated>
	<cdecl: RlShader 'LoadShader' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadTextureCubemapImage: image layout: layout [
	"Load cubemap from image, multiple image cubemap layouts supported
	image - Image
	layout - int"
	<generated>
	<cdecl: RlTexture 'LoadTextureCubemap' (RlImage, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadTextureFileName: fileName [
	"Load texture from file into GPU memory (VRAM)
	fileName - const char *"
	<generated>
	<cdecl: RlTexture 'LoadTexture' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadTextureFromImage: image [
	"Load texture from image data
	image - Image"
	<generated>
	<cdecl: RlTexture 'LoadTextureFromImage' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadUTF8Codepoints: codepoints length: length [
	"Load UTF-8 text encoded from codepoints array
	codepoints - const int *
	length - int"
	<generated>
	<cdecl: char8_t* 'LoadUTF8' (int32_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadVrStereoConfigDevice: device [
	"Load VR stereo config for VR simulator device parameters
	device - VrDeviceInfo"
	<generated>
	<cdecl: RlVrStereoConfig 'LoadVrStereoConfig' (RlVrDeviceInfo)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadWaveFileName: fileName [
	"Load wave data from file
	fileName - const char *"
	<generated>
	<cdecl: RlWave 'LoadWave' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadWaveFromMemoryFileType: fileType fileData: fileData dataSize: dataSize [
	"Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
	fileType - const char *
	fileData - const unsigned char *
	dataSize - int"
	<generated>
	<cdecl: RlWave 'LoadWaveFromMemory' (char8_t*, uchar8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> loadWaveSamplesWave: wave [
	"Load samples data from wave as a 32bit float data array
	wave - Wave"
	<generated>
	<cdecl: float* 'LoadWaveSamples' (RlWave)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> makeDirectoryDirPath: dirPath [
	"Create directories (including full path requested), returns 0 on success
	dirPath - const char *"
	<generated>
	<cdecl: int32_t 'MakeDirectory' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> maximizeWindow [
	"Set window state: maximized, if resizable
"
	<generated>
	<cdecl: void 'MaximizeWindow' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> measureText: text fontSize: fontSize [
	"Measure string width for default font
	text - const char *
	fontSize - int"
	<generated>
	<cdecl: int32_t 'MeasureText' (char8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> measureTextExFont: font text: text fontSize: fontSize spacing: spacing [
	"Measure string size for Font
	font - Font
	text - const char *
	fontSize - float
	spacing - float"
	<generated>
	<cdecl: RlVector2 'MeasureTextEx' (RlFont, char8_t*, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> memAllocSize: size [
	"Internal memory allocator
	size - unsigned int"
	<generated>
	<cdecl: void* 'MemAlloc' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> memFreePtr: ptr [
	"Internal memory free
	ptr - void *"
	<generated>
	<cdecl: void 'MemFree' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> memReallocPtr: ptr size: size [
	"Internal memory reallocator
	ptr - void *
	size - unsigned int"
	<generated>
	<cdecl: void* 'MemRealloc' (void*, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> minimizeWindow [
	"Set window state: minimized, if resizable
"
	<generated>
	<cdecl: void 'MinimizeWindow' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> openURL: url [
	"Open URL with default system browser (if available)
	url - const char *"
	<generated>
	<cdecl: void 'OpenURL' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> playAutomationEvent: event [
	"Play a recorded automation event
	event - AutomationEvent"
	<generated>
	<cdecl: void 'PlayAutomationEvent' (RlAutomationEvent)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> pollInputEvents [
	"Register all input events
"
	<generated>
	<cdecl: void 'PollInputEvents' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> restoreWindow [
	"Set window state: not minimized/maximized
"
	<generated>
	<cdecl: void 'RestoreWindow' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlActiveDrawBuffersCount: count [
	"Activate multiple draw color buffers
	count - int"
	<generated>
	<cdecl: void 'rlActiveDrawBuffers' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlActiveTextureSlot: slot [
	"Select and active a texture slot
	slot - int"
	<generated>
	<cdecl: void 'rlActiveTextureSlot' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlBeginMode: mode [
	"Initialize drawing mode (how to organize vertex)
	mode - int"
	<generated>
	<cdecl: void 'rlBegin' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlBindFramebufferTarget: target framebuffer: framebuffer [
	"Bind framebuffer (FBO)
	target - unsigned int
	framebuffer - unsigned int"
	<generated>
	<cdecl: void 'rlBindFramebuffer' (uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlBindImageTextureId: id index: index format: format readonly: readonly [
	"Bind image texture
	id - unsigned int
	index - unsigned int
	format - int
	readonly - bool"
	<generated>
	<cdecl: void 'rlBindImageTexture' (uint32_t, uint32_t, int32_t, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlBindShaderBufferId: id index: index [
	"Bind SSBO buffer
	id - unsigned int
	index - unsigned int"
	<generated>
	<cdecl: void 'rlBindShaderBuffer' (uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlBlitFramebufferSrcX: srcX srcY: srcY srcWidth: srcWidth srcHeight: srcHeight dstX: dstX dstY: dstY dstWidth: dstWidth dstHeight: dstHeight bufferMask: bufferMask [
	"Blit active framebuffer to main framebuffer
	srcX - int
	srcY - int
	srcWidth - int
	srcHeight - int
	dstX - int
	dstY - int
	dstWidth - int
	dstHeight - int
	bufferMask - int"
	<generated>
	<cdecl: void 'rlBlitFramebuffer' (int32_t, int32_t, int32_t, int32_t, int32_t, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlCheckErrors [
	"Check and log OpenGL error codes
"
	<generated>
	<cdecl: void 'rlCheckErrors' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlCheckRenderBatchLimitVCount: vCount [
	"Check internal buffer overflow for a given number of vertex
	vCount - int"
	<generated>
	<cdecl: bool 'rlCheckRenderBatchLimit' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlClearColor: r g: g b: b a: a [
	"Clear color buffer with color
	r - unsigned char
	g - unsigned char
	b - unsigned char
	a - unsigned char"
	<generated>
	<cdecl: void 'rlClearColor' (uchar8_t, uchar8_t, uchar8_t, uchar8_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlClearScreenBuffers [
	"Clear used screen buffers (color and depth)
"
	<generated>
	<cdecl: void 'rlClearScreenBuffers' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlColor3fX: x y: y z: z [
	"Define one vertex (color) - 3 float
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlColor3f' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlColor4fX: x y: y z: z w: w [
	"Define one vertex (color) - 4 float
	x - float
	y - float
	z - float
	w - float"
	<generated>
	<cdecl: void 'rlColor4f' (float, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlColor4ubR: r g: g b: b a: a [
	"Define one vertex (color) - 4 byte
	r - unsigned char
	g - unsigned char
	b - unsigned char
	a - unsigned char"
	<generated>
	<cdecl: void 'rlColor4ub' (uchar8_t, uchar8_t, uchar8_t, uchar8_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlColorMaskR: r g: g b: b a: a [
	"Color mask control
	r - bool
	g - bool
	b - bool
	a - bool"
	<generated>
	<cdecl: void 'rlColorMask' (bool, bool, bool, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlCompileShaderShaderCode: shaderCode type: type [
	"Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
	shaderCode - const char *
	type - int"
	<generated>
	<cdecl: uint32_t 'rlCompileShader' (char8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlComputeShaderDispatchGroupX: groupX groupY: groupY groupZ: groupZ [
	"Dispatch compute shader (equivalent to *draw* for graphics pipeline)
	groupX - unsigned int
	groupY - unsigned int
	groupZ - unsigned int"
	<generated>
	<cdecl: void 'rlComputeShaderDispatch' (uint32_t, uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlCopyShaderBufferDestId: destId srcId: srcId destOffset: destOffset srcOffset: srcOffset count: count [
	"Copy SSBO data between buffers
	destId - unsigned int
	srcId - unsigned int
	destOffset - unsigned int
	srcOffset - unsigned int
	count - unsigned int"
	<generated>
	<cdecl: void 'rlCopyShaderBuffer' (uint32_t, uint32_t, uint32_t, uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlCubemapParametersId: id param: param value: value [
	"Set cubemap parameters (filter, wrap)
	id - unsigned int
	param - int
	value - int"
	<generated>
	<cdecl: void 'rlCubemapParameters' (uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableBackfaceCulling [
	"Disable backface culling
"
	<generated>
	<cdecl: void 'rlDisableBackfaceCulling' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableColorBlend [
	"Disable color blending
"
	<generated>
	<cdecl: void 'rlDisableColorBlend' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableDepthMask [
	"Disable depth write
"
	<generated>
	<cdecl: void 'rlDisableDepthMask' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableDepthTest [
	"Disable depth test
"
	<generated>
	<cdecl: void 'rlDisableDepthTest' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableFramebuffer [
	"Disable render texture (fbo), return to default framebuffer
"
	<generated>
	<cdecl: void 'rlDisableFramebuffer' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisablePointMode [
	"Disable point mode
"
	<generated>
	<cdecl: void 'rlDisablePointMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableScissorTest [
	"Disable scissor test
"
	<generated>
	<cdecl: void 'rlDisableScissorTest' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableShader [
	"Disable shader program
"
	<generated>
	<cdecl: void 'rlDisableShader' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableSmoothLines [
	"Disable line aliasing
"
	<generated>
	<cdecl: void 'rlDisableSmoothLines' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableStatePointerVertexAttribType: vertexAttribType [
	"Disable attribute state pointer
	vertexAttribType - int"
	<generated>
	<cdecl: void 'rlDisableStatePointer' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableStereoRender [
	"Disable stereo rendering
"
	<generated>
	<cdecl: void 'rlDisableStereoRender' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableTexture [
	"Disable texture
"
	<generated>
	<cdecl: void 'rlDisableTexture' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableTextureCubemap [
	"Disable texture cubemap
"
	<generated>
	<cdecl: void 'rlDisableTextureCubemap' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableVertexArray [
	"Disable vertex array (VAO, if supported)
"
	<generated>
	<cdecl: void 'rlDisableVertexArray' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableVertexAttributeIndex: index [
	"Disable vertex attribute index
	index - unsigned int"
	<generated>
	<cdecl: void 'rlDisableVertexAttribute' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableVertexBuffer [
	"Disable vertex buffer (VBO)
"
	<generated>
	<cdecl: void 'rlDisableVertexBuffer' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableVertexBufferElement [
	"Disable vertex buffer element (VBO element)
"
	<generated>
	<cdecl: void 'rlDisableVertexBufferElement' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDisableWireMode [
	"Disable wire mode
"
	<generated>
	<cdecl: void 'rlDisableWireMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawRenderBatch: batch [
	"Draw render batch data (Update->Draw->Reset)
	batch - rlRenderBatch *"
	<generated>
	<cdecl: void 'rlDrawRenderBatch' (RlRlRenderBatch*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawRenderBatchActive [
	"Update and draw internal render batch
"
	<generated>
	<cdecl: void 'rlDrawRenderBatchActive' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawVertexArrayElementsInstancedOffset: offset count: count buffer: buffer instances: instances [
	"Draw vertex array elements with instancing
	offset - int
	count - int
	buffer - const void *
	instances - int"
	<generated>
	<cdecl: void 'rlDrawVertexArrayElementsInstanced' (int32_t, int32_t, void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawVertexArrayElementsOffset: offset count: count buffer: buffer [
	"Draw vertex array elements
	offset - int
	count - int
	buffer - const void *"
	<generated>
	<cdecl: void 'rlDrawVertexArrayElements' (int32_t, int32_t, void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawVertexArrayInstancedOffset: offset count: count instances: instances [
	"Draw vertex array (currently active vao) with instancing
	offset - int
	count - int
	instances - int"
	<generated>
	<cdecl: void 'rlDrawVertexArrayInstanced' (int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlDrawVertexArrayOffset: offset count: count [
	"Draw vertex array (currently active vao)
	offset - int
	count - int"
	<generated>
	<cdecl: void 'rlDrawVertexArray' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableBackfaceCulling [
	"Enable backface culling
"
	<generated>
	<cdecl: void 'rlEnableBackfaceCulling' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableColorBlend [
	"Enable color blending
"
	<generated>
	<cdecl: void 'rlEnableColorBlend' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableDepthMask [
	"Enable depth write
"
	<generated>
	<cdecl: void 'rlEnableDepthMask' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableDepthTest [
	"Enable depth test
"
	<generated>
	<cdecl: void 'rlEnableDepthTest' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableFramebufferId: id [
	"Enable render texture (fbo)
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableFramebuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnablePointMode [
	"Enable point mode
"
	<generated>
	<cdecl: void 'rlEnablePointMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableScissorTest [
	"Enable scissor test
"
	<generated>
	<cdecl: void 'rlEnableScissorTest' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableShaderId: id [
	"Enable shader program
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableShader' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableSmoothLines [
	"Enable line aliasing
"
	<generated>
	<cdecl: void 'rlEnableSmoothLines' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableStatePointerVertexAttribType: vertexAttribType buffer: buffer [
	"Enable attribute state pointer
	vertexAttribType - int
	buffer - void *"
	<generated>
	<cdecl: void 'rlEnableStatePointer' (int32_t, void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableStereoRender [
	"Enable stereo rendering
"
	<generated>
	<cdecl: void 'rlEnableStereoRender' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableTextureCubemapId: id [
	"Enable texture cubemap
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableTextureCubemap' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableTextureId: id [
	"Enable texture
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableTexture' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableVertexArrayVaoId: vaoId [
	"Enable vertex array (VAO, if supported)
	vaoId - unsigned int"
	<generated>
	<cdecl: bool 'rlEnableVertexArray' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableVertexAttributeIndex: index [
	"Enable vertex attribute index
	index - unsigned int"
	<generated>
	<cdecl: void 'rlEnableVertexAttribute' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableVertexBufferElementId: id [
	"Enable vertex buffer element (VBO element)
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableVertexBufferElement' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableVertexBufferId: id [
	"Enable vertex buffer (VBO)
	id - unsigned int"
	<generated>
	<cdecl: void 'rlEnableVertexBuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnableWireMode [
	"Enable wire mode
"
	<generated>
	<cdecl: void 'rlEnableWireMode' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlEnd [
	"Finish vertex providing
"
	<generated>
	<cdecl: void 'rlEnd' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlFramebufferAttachFboId: fboId texId: texId attachType: attachType texType: texType mipLevel: mipLevel [
	"Attach texture/renderbuffer to a framebuffer
	fboId - unsigned int
	texId - unsigned int
	attachType - int
	texType - int
	mipLevel - int"
	<generated>
	<cdecl: void 'rlFramebufferAttach' (uint32_t, uint32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlFramebufferCompleteId: id [
	"Verify framebuffer is complete
	id - unsigned int"
	<generated>
	<cdecl: bool 'rlFramebufferComplete' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlFrustumLeft: left right: right bottom: bottom top: top znear: znear zfar: zfar [
	"
	left - double
	right - double
	bottom - double
	top - double
	znear - double
	zfar - double"
	<generated>
	<cdecl: void 'rlFrustum' (double, double, double, double, double, double)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGenTextureMipmapsId: id width: width height: height format: format mipmaps: mipmaps [
	"Generate mipmap data for selected texture
	id - unsigned int
	width - int
	height - int
	format - int
	mipmaps - int *"
	<generated>
	<cdecl: void 'rlGenTextureMipmaps' (uint32_t, int32_t, int32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetActiveFramebuffer [
	"Get the currently active render texture (fbo), 0 for default framebuffer
"
	<generated>
	<cdecl: uint32_t 'rlGetActiveFramebuffer' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetCullDistanceFar [
	"Get cull plane distance far
"
	<generated>
	<cdecl: double 'rlGetCullDistanceFar' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetCullDistanceNear [
	"Get cull plane distance near
"
	<generated>
	<cdecl: double 'rlGetCullDistanceNear' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetFramebufferHeight [
	"Get default framebuffer height
"
	<generated>
	<cdecl: int32_t 'rlGetFramebufferHeight' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetFramebufferWidth [
	"Get default framebuffer width
"
	<generated>
	<cdecl: int32_t 'rlGetFramebufferWidth' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetGlTextureFormatsFormat: format glInternalFormat: glInternalFormat glFormat: glFormat glType: glType [
	"Get OpenGL internal formats
	format - int
	glInternalFormat - unsigned int *
	glFormat - unsigned int *
	glType - unsigned int *"
	<generated>
	<cdecl: void 'rlGetGlTextureFormats' (int32_t, uint32_t*, uint32_t*, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetLineWidth [
	"Get the line drawing width
"
	<generated>
	<cdecl: float 'rlGetLineWidth' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetLocationAttribShaderId: shaderId attribName: attribName [
	"Get shader location attribute
	shaderId - unsigned int
	attribName - const char *"
	<generated>
	<cdecl: int32_t 'rlGetLocationAttrib' (uint32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetLocationUniformShaderId: shaderId uniformName: uniformName [
	"Get shader location uniform
	shaderId - unsigned int
	uniformName - const char *"
	<generated>
	<cdecl: int32_t 'rlGetLocationUniform' (uint32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetMatrixModelview [
	"Get internal modelview matrix
"
	<generated>
	<cdecl: RlMatrix 'rlGetMatrixModelview' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetMatrixProjection [
	"Get internal projection matrix
"
	<generated>
	<cdecl: RlMatrix 'rlGetMatrixProjection' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetMatrixProjectionStereoEye: eye [
	"Get internal projection matrix for stereo render (selected eye)
	eye - int"
	<generated>
	<cdecl: RlMatrix 'rlGetMatrixProjectionStereo' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetMatrixTransform [
	"Get internal accumulated transform matrix
"
	<generated>
	<cdecl: RlMatrix 'rlGetMatrixTransform' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetMatrixViewOffsetStereoEye: eye [
	"Get internal view offset matrix for stereo render (selected eye)
	eye - int"
	<generated>
	<cdecl: RlMatrix 'rlGetMatrixViewOffsetStereo' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetPixelFormatNameFormat: format [
	"Get name string for pixel format
	format - unsigned int"
	<generated>
	<cdecl: char8_t* 'rlGetPixelFormatName' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetShaderBufferSizeId: id [
	"Get SSBO buffer size
	id - unsigned int"
	<generated>
	<cdecl: uint32_t 'rlGetShaderBufferSize' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetShaderIdDefault [
	"Get default shader id
"
	<generated>
	<cdecl: uint32_t 'rlGetShaderIdDefault' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetShaderLocsDefault [
	"Get default shader locations
"
	<generated>
	<cdecl: int32_t* 'rlGetShaderLocsDefault' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetTextureIdDefault [
	"Get default texture id
"
	<generated>
	<cdecl: uint32_t 'rlGetTextureIdDefault' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlGetVersion [
	"Get current OpenGL version
"
	<generated>
	<cdecl: int32_t 'rlGetVersion' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlIsStereoRenderEnabled [
	"Check if stereo render is enabled
"
	<generated>
	<cdecl: bool 'rlIsStereoRenderEnabled' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadComputeShaderProgramShaderId: shaderId [
	"Load compute shader program
	shaderId - unsigned int"
	<generated>
	<cdecl: uint32_t 'rlLoadComputeShaderProgram' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadDrawCube [
	"Load and draw a cube
"
	<generated>
	<cdecl: void 'rlLoadDrawCube' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadDrawQuad [
	"Load and draw a quad
"
	<generated>
	<cdecl: void 'rlLoadDrawQuad' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadExtensionsLoader: loader [
	"Load OpenGL extensions (loader function required)
	loader - void *"
	<generated>
	<cdecl: void 'rlLoadExtensions' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadFramebuffer [
	"Load an empty framebuffer
"
	<generated>
	<cdecl: uint32_t 'rlLoadFramebuffer' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadIdentity [
	"Reset current matrix to identity matrix
"
	<generated>
	<cdecl: void 'rlLoadIdentity' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadRenderBatchNumBuffers: numBuffers bufferElements: bufferElements [
	"Load a render batch system
	numBuffers - int
	bufferElements - int"
	<generated>
	<cdecl: RlRlRenderBatch 'rlLoadRenderBatch' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadShaderBufferSize: size data: data usageHint: usageHint [
	"Load shader storage buffer object (SSBO)
	size - unsigned int
	data - const void *
	usageHint - int"
	<generated>
	<cdecl: uint32_t 'rlLoadShaderBuffer' (uint32_t, void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadShaderCodeVsCode: vsCode fsCode: fsCode [
	"Load shader from code strings
	vsCode - const char *
	fsCode - const char *"
	<generated>
	<cdecl: uint32_t 'rlLoadShaderCode' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadShaderProgramVShaderId: vShaderId fShaderId: fShaderId [
	"Load custom shader program
	vShaderId - unsigned int
	fShaderId - unsigned int"
	<generated>
	<cdecl: uint32_t 'rlLoadShaderProgram' (uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadTextureCubemapData: data size: size format: format mipmapCount: mipmapCount [
	"Load texture cubemap data
	data - const void *
	size - int
	format - int
	mipmapCount - int"
	<generated>
	<cdecl: uint32_t 'rlLoadTextureCubemap' (void*, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadTextureData: data width: width height: height format: format mipmapCount: mipmapCount [
	"Load texture data
	data - const void *
	width - int
	height - int
	format - int
	mipmapCount - int"
	<generated>
	<cdecl: uint32_t 'rlLoadTexture' (void*, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadTextureDepthWidth: width height: height useRenderBuffer: useRenderBuffer [
	"Load depth texture/renderbuffer (to be attached to fbo)
	width - int
	height - int
	useRenderBuffer - bool"
	<generated>
	<cdecl: uint32_t 'rlLoadTextureDepth' (int32_t, int32_t, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadVertexArray [
	"Load vertex array (vao) if supported
"
	<generated>
	<cdecl: uint32_t 'rlLoadVertexArray' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadVertexBuffer: buffer size: size dynamic: dynamic [
	"Load a vertex buffer object
	buffer - const void *
	size - int
	dynamic - bool"
	<generated>
	<cdecl: uint32_t 'rlLoadVertexBuffer' (void*, int32_t, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlLoadVertexBufferElementBuffer: buffer size: size dynamic: dynamic [
	"Load vertex buffer elements object
	buffer - const void *
	size - int
	dynamic - bool"
	<generated>
	<cdecl: uint32_t 'rlLoadVertexBufferElement' (void*, int32_t, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlMatrixMode: mode [
	"Choose the current matrix to be transformed
	mode - int"
	<generated>
	<cdecl: void 'rlMatrixMode' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlMultMatrixfMatf: matf [
	"Multiply the current matrix by another matrix
	matf - const float *"
	<generated>
	<cdecl: void 'rlMultMatrixf' (float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlNormal3fX: x y: y z: z [
	"Define one vertex (normal) - 3 float
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlNormal3f' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRBegin [
	"
"
	<generated>
	<cdecl: bool 'rlOpenXRBegin' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRBeginMockHMD [
	"
"
	<generated>
	<cdecl: bool 'rlOpenXRBeginMockHMD' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRBlitToWindowEye: eye keep_aspect_ratio: keep_aspect_ratio [
	"
	eye - RLOpenXREyeEnum
	keep_aspect_ratio - bool"
	<generated>
	<cdecl: void 'rlOpenXRBlitToWindow' (int, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRData [
	"
"
	<generated>
	<cdecl: RlRLOpenXRData* 'rlOpenXRData' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXREnd [
	"
"
	<generated>
	<cdecl: void 'rlOpenXREnd' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRSetup [
	"
"
	<generated>
	<cdecl: bool 'rlOpenXRSetup' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRShutdown [
	"
"
	<generated>
	<cdecl: void 'rlOpenXRShutdown' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRSyncSingleActionSetAction_set: action_set [
	"Utility function for xrSyncAction with a single action set.
	action_set - XrActionSet"
	<generated>
	<cdecl: void 'rlOpenXRSyncSingleActionSet' (XrActionSet)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRUpdate [
	"
"
	<generated>
	<cdecl: void 'rlOpenXRUpdate' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRUpdateCamera: camera [
	"
	camera - Camera3D *"
	<generated>
	<cdecl: void 'rlOpenXRUpdateCamera' (RlCamera3D*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRUpdateCameraTransform: transform [
	"
	transform - Transform *"
	<generated>
	<cdecl: void 'rlOpenXRUpdateCameraTransform' (RlTransform*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOpenXRUpdateHandsLeft: left right: right [
	"
	left - RLHand *
	right - RLHand *"
	<generated>
	<cdecl: void 'rlOpenXRUpdateHands' (RlRLHand*, RlRLHand*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlOrthoLeft: left right: right bottom: bottom top: top znear: znear zfar: zfar [
	"
	left - double
	right - double
	bottom - double
	top - double
	znear - double
	zfar - double"
	<generated>
	<cdecl: void 'rlOrtho' (double, double, double, double, double, double)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlPopMatrix [
	"Pop latest inserted matrix from stack
"
	<generated>
	<cdecl: void 'rlPopMatrix' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlPushMatrix [
	"Push the current matrix to stack
"
	<generated>
	<cdecl: void 'rlPushMatrix' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlReadScreenPixelsWidth: width height: height [
	"Read screen pixel data (color buffer)
	width - int
	height - int"
	<generated>
	<cdecl: uchar8_t* 'rlReadScreenPixels' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlReadShaderBufferId: id dest: dest count: count offset: offset [
	"Read SSBO buffer data (GPU->CPU)
	id - unsigned int
	dest - void *
	count - unsigned int
	offset - unsigned int"
	<generated>
	<cdecl: void 'rlReadShaderBuffer' (uint32_t, void*, uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlReadTexturePixelsId: id width: width height: height format: format [
	"Read texture pixel data
	id - unsigned int
	width - int
	height - int
	format - int"
	<generated>
	<cdecl: void* 'rlReadTexturePixels' (uint32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlRotatefAngle: angle x: x y: y z: z [
	"Multiply the current matrix by a rotation matrix
	angle - float
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlRotatef' (float, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlScalefX: x y: y z: z [
	"Multiply the current matrix by a scaling matrix
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlScalef' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlScissorX: x y: y width: width height: height [
	"Scissor test
	x - int
	y - int
	width - int
	height - int"
	<generated>
	<cdecl: void 'rlScissor' (int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetBlendFactorsGlSrcFactor: glSrcFactor glDstFactor: glDstFactor glEquation: glEquation [
	"Set blending mode factor and equation (using OpenGL factors)
	glSrcFactor - int
	glDstFactor - int
	glEquation - int"
	<generated>
	<cdecl: void 'rlSetBlendFactors' (int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetBlendFactorsSeparateGlSrcRGB: glSrcRGB glDstRGB: glDstRGB glSrcAlpha: glSrcAlpha glDstAlpha: glDstAlpha glEqRGB: glEqRGB glEqAlpha: glEqAlpha [
	"Set blending mode factors and equations separately (using OpenGL factors)
	glSrcRGB - int
	glDstRGB - int
	glSrcAlpha - int
	glDstAlpha - int
	glEqRGB - int
	glEqAlpha - int"
	<generated>
	<cdecl: void 'rlSetBlendFactorsSeparate' (int32_t, int32_t, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetBlendMode: mode [
	"Set blending mode
	mode - int"
	<generated>
	<cdecl: void 'rlSetBlendMode' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetClipPlanesNearPlane: nearPlane farPlane: farPlane [
	"Set clip planes distances
	nearPlane - double
	farPlane - double"
	<generated>
	<cdecl: void 'rlSetClipPlanes' (double, double)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetCullFaceMode: mode [
	"Set face culling mode
	mode - int"
	<generated>
	<cdecl: void 'rlSetCullFace' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetFramebufferHeight: height [
	"Set current framebuffer height
	height - int"
	<generated>
	<cdecl: void 'rlSetFramebufferHeight' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetFramebufferWidth: width [
	"Set current framebuffer width
	width - int"
	<generated>
	<cdecl: void 'rlSetFramebufferWidth' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetLineWidth: width [
	"Set the line drawing width
	width - float"
	<generated>
	<cdecl: void 'rlSetLineWidth' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetMatrixModelview: view [
	"Set a custom modelview matrix (replaces internal modelview matrix)
	view - Matrix"
	<generated>
	<cdecl: void 'rlSetMatrixModelview' (RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetMatrixProjectionProj: proj [
	"Set a custom projection matrix (replaces internal projection matrix)
	proj - Matrix"
	<generated>
	<cdecl: void 'rlSetMatrixProjection' (RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetMatrixProjectionStereoRight: right left: left [
	"Set eyes projection matrices for stereo rendering
	right - Matrix
	left - Matrix"
	<generated>
	<cdecl: void 'rlSetMatrixProjectionStereo' (RlMatrix, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetMatrixViewOffsetStereoRight: right left: left [
	"Set eyes view offsets matrices for stereo rendering
	right - Matrix
	left - Matrix"
	<generated>
	<cdecl: void 'rlSetMatrixViewOffsetStereo' (RlMatrix, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetRenderBatchActiveBatch: batch [
	"Set the active render batch for rlgl (NULL for default internal)
	batch - rlRenderBatch *"
	<generated>
	<cdecl: void 'rlSetRenderBatchActive' (RlRlRenderBatch*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetShaderId: id locs: locs [
	"Set shader currently active (id and locations)
	id - unsigned int
	locs - int *"
	<generated>
	<cdecl: void 'rlSetShader' (uint32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetTextureId: id [
	"Set current texture for render batch and check buffers limits
	id - unsigned int"
	<generated>
	<cdecl: void 'rlSetTexture' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetUniformLocIndex: locIndex value: value uniformType: uniformType count: count [
	"Set shader value uniform
	locIndex - int
	value - const void *
	uniformType - int
	count - int"
	<generated>
	<cdecl: void 'rlSetUniform' (int32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetUniformMatricesLocIndex: locIndex mat: mat count: count [
	"Set shader value matrices
	locIndex - int
	mat - const Matrix *
	count - int"
	<generated>
	<cdecl: void 'rlSetUniformMatrices' (int32_t, RlMatrix*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetUniformMatrixLocIndex: locIndex mat: mat [
	"Set shader value matrix
	locIndex - int
	mat - Matrix"
	<generated>
	<cdecl: void 'rlSetUniformMatrix' (int32_t, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetUniformSamplerLocIndex: locIndex textureId: textureId [
	"Set shader value sampler
	locIndex - int
	textureId - unsigned int"
	<generated>
	<cdecl: void 'rlSetUniformSampler' (int32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetVertexAttributeDefaultLocIndex: locIndex value: value attribType: attribType count: count [
	"Set vertex attribute default value, when attribute to provided
	locIndex - int
	value - const void *
	attribType - int
	count - int"
	<generated>
	<cdecl: void 'rlSetVertexAttributeDefault' (int32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetVertexAttributeDivisorIndex: index divisor: divisor [
	"Set vertex attribute data divisor
	index - unsigned int
	divisor - int"
	<generated>
	<cdecl: void 'rlSetVertexAttributeDivisor' (uint32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlSetVertexAttributeIndex: index compSize: compSize type: type normalized: normalized stride: stride offset: offset [
	"Set vertex attribute data configuration
	index - unsigned int
	compSize - int
	type - int
	normalized - bool
	stride - int
	offset - int"
	<generated>
	<cdecl: void 'rlSetVertexAttribute' (uint32_t, int32_t, int32_t, bool, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlTexCoord2fX: x y: y [
	"Define one vertex (texture coordinate) - 2 float
	x - float
	y - float"
	<generated>
	<cdecl: void 'rlTexCoord2f' (float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlTextureParametersId: id param: param value: value [
	"Set texture parameters (filter, wrap)
	id - unsigned int
	param - int
	value - int"
	<generated>
	<cdecl: void 'rlTextureParameters' (uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlTranslatefX: x y: y z: z [
	"Multiply the current matrix by a translation matrix
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlTranslatef' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadFramebufferId: id [
	"Delete framebuffer from GPU
	id - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadFramebuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadRenderBatch: batch [
	"Unload render batch system
	batch - rlRenderBatch"
	<generated>
	<cdecl: void 'rlUnloadRenderBatch' (RlRlRenderBatch)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadShaderBufferSsboId: ssboId [
	"Unload shader storage buffer object (SSBO)
	ssboId - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadShaderBuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadShaderProgramId: id [
	"Unload shader program
	id - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadShaderProgram' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadTextureId: id [
	"Unload texture from GPU memory
	id - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadTexture' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadVertexArrayVaoId: vaoId [
	"Unload vertex array (vao)
	vaoId - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadVertexArray' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUnloadVertexBufferVboId: vboId [
	"Unload vertex buffer object
	vboId - unsigned int"
	<generated>
	<cdecl: void 'rlUnloadVertexBuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUpdateShaderBufferId: id data: data dataSize: dataSize offset: offset [
	"Update SSBO buffer data
	id - unsigned int
	data - const void *
	dataSize - unsigned int
	offset - unsigned int"
	<generated>
	<cdecl: void 'rlUpdateShaderBuffer' (uint32_t, void*, uint32_t, uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUpdateTextureId: id offsetX: offsetX offsetY: offsetY width: width height: height format: format data: data [
	"Update texture with new data on GPU
	id - unsigned int
	offsetX - int
	offsetY - int
	width - int
	height - int
	format - int
	data - const void *"
	<generated>
	<cdecl: void 'rlUpdateTexture' (uint32_t, int32_t, int32_t, int32_t, int32_t, int32_t, void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUpdateVertexBufferBufferId: bufferId data: data dataSize: dataSize offset: offset [
	"Update vertex buffer object data on GPU buffer
	bufferId - unsigned int
	data - const void *
	dataSize - int
	offset - int"
	<generated>
	<cdecl: void 'rlUpdateVertexBuffer' (uint32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlUpdateVertexBufferElementsId: id data: data dataSize: dataSize offset: offset [
	"Update vertex buffer elements data on GPU buffer
	id - unsigned int
	data - const void *
	dataSize - int
	offset - int"
	<generated>
	<cdecl: void 'rlUpdateVertexBufferElements' (uint32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlVertex2fX: x y: y [
	"Define one vertex (position) - 2 float
	x - float
	y - float"
	<generated>
	<cdecl: void 'rlVertex2f' (float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlVertex2iX: x y: y [
	"Define one vertex (position) - 2 int
	x - int
	y - int"
	<generated>
	<cdecl: void 'rlVertex2i' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlVertex3fX: x y: y z: z [
	"Define one vertex (position) - 3 float
	x - float
	y - float
	z - float"
	<generated>
	<cdecl: void 'rlVertex3f' (float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlViewportX: x y: y width: width height: height [
	"Set the viewport area
	x - int
	y - int
	width - int
	height - int"
	<generated>
	<cdecl: void 'rlViewport' (int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlglClose [
	"De-initialize rlgl (buffers, shaders, textures)
"
	<generated>
	<cdecl: void 'rlglClose' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> rlglInitWidth: width height: height [
	"Initialize rlgl (buffers, shaders, textures, states)
	width - int
	height - int"
	<generated>
	<cdecl: void 'rlglInit' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> saveFileDataFileName: fileName data: data dataSize: dataSize [
	"Save data to file from byte array (write), returns true on success
	fileName - const char *
	data - void *
	dataSize - int"
	<generated>
	<cdecl: bool 'SaveFileData' (char8_t*, void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> saveFileTextFileName: fileName text: text [
	"Save text data to file (write), string must be '\0' terminated, returns true on success
	fileName - const char *
	text - char *"
	<generated>
	<cdecl: bool 'SaveFileText' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setAutomationEventBaseFrame: frame [
	"Set automation event internal base frame to start recording
	frame - int"
	<generated>
	<cdecl: void 'SetAutomationEventBaseFrame' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setAutomationEventList: list [
	"Set automation event list to record to
	list - AutomationEventList *"
	<generated>
	<cdecl: void 'SetAutomationEventList' (RlAutomationEventList*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setClipboardText: text [
	"Set clipboard text content
	text - const char *"
	<generated>
	<cdecl: void 'SetClipboardText' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setConfigFlags: flags [
	"Setup init configuration flags (view FLAGS)
	flags - unsigned int"
	<generated>
	<cdecl: void 'SetConfigFlags' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setExitKey: key [
	"Set a custom key to exit program (default is ESC)
	key - int"
	<generated>
	<cdecl: void 'SetExitKey' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setGamepadMappings: mappings [
	"Set internal gamepad mappings (SDL_GameControllerDB)
	mappings - const char *"
	<generated>
	<cdecl: int32_t 'SetGamepadMappings' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setGamepadVibrationGamepad: gamepad leftMotor: leftMotor rightMotor: rightMotor duration: duration [
	"Set gamepad vibration for both motors (duration in seconds)
	gamepad - int
	leftMotor - float
	rightMotor - float
	duration - float"
	<generated>
	<cdecl: void 'SetGamepadVibration' (int32_t, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setGesturesEnabledFlags: flags [
	"Enable a set of gestures using flags
	flags - unsigned int"
	<generated>
	<cdecl: void 'SetGesturesEnabled' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setLoadFileDataCallback: callback [
	"Set custom file binary data loader
	callback - LoadFileDataCallback"
	<generated>
	<cdecl: void 'SetLoadFileDataCallback' (RlLoadFileDataCallback)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setLoadFileTextCallback: callback [
	"Set custom file text data loader
	callback - LoadFileTextCallback"
	<generated>
	<cdecl: void 'SetLoadFileTextCallback' (RlLoadFileTextCallback)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMasterVolume: volume [
	"Set master volume (listener)
	volume - float"
	<generated>
	<cdecl: void 'SetMasterVolume' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMaterialTextureMaterial: material mapType: mapType texture: texture [
	"Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
	material - Material *
	mapType - int
	texture - Texture2D"
	<generated>
	<cdecl: void 'SetMaterialTexture' (RlMaterial*, int32_t, RlTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setModelMeshMaterialModel: model meshId: meshId materialId: materialId [
	"Set material for a mesh
	model - Model *
	meshId - int
	materialId - int"
	<generated>
	<cdecl: void 'SetModelMeshMaterial' (RlModel*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMouseCursor: cursor [
	"Set mouse cursor
	cursor - int"
	<generated>
	<cdecl: void 'SetMouseCursor' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMouseOffsetOffsetX: offsetX offsetY: offsetY [
	"Set mouse offset
	offsetX - int
	offsetY - int"
	<generated>
	<cdecl: void 'SetMouseOffset' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMousePositionX: x y: y [
	"Set mouse position XY
	x - int
	y - int"
	<generated>
	<cdecl: void 'SetMousePosition' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setMouseScaleScaleX: scaleX scaleY: scaleY [
	"Set mouse scaling
	scaleX - float
	scaleY - float"
	<generated>
	<cdecl: void 'SetMouseScale' (float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setPixelColorDstPtr: dstPtr color: color format: format [
	"Set color formatted into destination pixel pointer
	dstPtr - void *
	color - Color
	format - int"
	<generated>
	<cdecl: void 'SetPixelColor' (void*, RlColor, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setRandomSeed: seed [
	"Set the seed for the random number generator
	seed - unsigned int"
	<generated>
	<cdecl: void 'SetRandomSeed' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setSaveFileDataCallback: callback [
	"Set custom file binary data saver
	callback - SaveFileDataCallback"
	<generated>
	<cdecl: void 'SetSaveFileDataCallback' (RlSaveFileDataCallback)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setSaveFileTextCallback: callback [
	"Set custom file text data saver
	callback - SaveFileTextCallback"
	<generated>
	<cdecl: void 'SetSaveFileTextCallback' (RlSaveFileTextCallback)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setShaderValueMatrixShader: shader locIndex: locIndex mat: mat [
	"Set shader uniform value (matrix 4x4)
	shader - Shader
	locIndex - int
	mat - Matrix"
	<generated>
	<cdecl: void 'SetShaderValueMatrix' (RlShader, int32_t, RlMatrix)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setShaderValueShader: shader locIndex: locIndex value: value uniformType: uniformType [
	"Set shader uniform value
	shader - Shader
	locIndex - int
	value - const void *
	uniformType - int"
	<generated>
	<cdecl: void 'SetShaderValue' (RlShader, int32_t, void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setShaderValueTextureShader: shader locIndex: locIndex texture: texture [
	"Set shader uniform value and bind the texture (sampler2d)
	shader - Shader
	locIndex - int
	texture - Texture2D"
	<generated>
	<cdecl: void 'SetShaderValueTexture' (RlShader, int32_t, RlTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setShaderValueVShader: shader locIndex: locIndex value: value uniformType: uniformType count: count [
	"Set shader uniform value vector
	shader - Shader
	locIndex - int
	value - const void *
	uniformType - int
	count - int"
	<generated>
	<cdecl: void 'SetShaderValueV' (RlShader, int32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setShapesTexture: texture source: source [
	"Set texture and rectangle to be used on shapes drawing
	texture - Texture2D
	source - Rectangle"
	<generated>
	<cdecl: void 'SetShapesTexture' (RlTexture, RlRectangle)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTargetFPS: fps [
	"Set target FPS (maximum)
	fps - int"
	<generated>
	<cdecl: void 'SetTargetFPS' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTextLineSpacing: spacing [
	"Set vertical line spacing when drawing with line-breaks
	spacing - int"
	<generated>
	<cdecl: void 'SetTextLineSpacing' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTextureFilterTexture: texture filter: filter [
	"Set texture scaling filter mode
	texture - Texture2D
	filter - int"
	<generated>
	<cdecl: void 'SetTextureFilter' (RlTexture, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTextureWrapTexture: texture wrap: wrap [
	"Set texture wrapping mode
	texture - Texture2D
	wrap - int"
	<generated>
	<cdecl: void 'SetTextureWrap' (RlTexture, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTraceLogCallback: callback [
	"Set custom trace log
	callback - TraceLogCallback"
	<generated>
	<cdecl: void 'SetTraceLogCallback' (RlTraceLogCallback)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setTraceLogLevel: logLevel [
	"Set the current threshold (minimum) log level
	logLevel - int"
	<generated>
	<cdecl: void 'SetTraceLogLevel' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowFocused [
	"Set window focused
"
	<generated>
	<cdecl: void 'SetWindowFocused' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowIconImage: image [
	"Set icon for window (single image, RGBA 32bit)
	image - Image"
	<generated>
	<cdecl: void 'SetWindowIcon' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowIconsImages: images count: count [
	"Set icon for window (multiple images, RGBA 32bit)
	images - Image *
	count - int"
	<generated>
	<cdecl: void 'SetWindowIcons' (RlImage*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowMaxSizeWidth: width height: height [
	"Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
	width - int
	height - int"
	<generated>
	<cdecl: void 'SetWindowMaxSize' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowMinSizeWidth: width height: height [
	"Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
	width - int
	height - int"
	<generated>
	<cdecl: void 'SetWindowMinSize' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowMonitor: monitor [
	"Set monitor for the current window
	monitor - int"
	<generated>
	<cdecl: void 'SetWindowMonitor' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowOpacity: opacity [
	"Set window opacity [0.0f..1.0f]
	opacity - float"
	<generated>
	<cdecl: void 'SetWindowOpacity' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowPositionX: x y: y [
	"Set window position on screen
	x - int
	y - int"
	<generated>
	<cdecl: void 'SetWindowPosition' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowSizeWidth: width height: height [
	"Set window dimensions
	width - int
	height - int"
	<generated>
	<cdecl: void 'SetWindowSize' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowStateFlags: flags [
	"Set window configuration state using flags
	flags - unsigned int"
	<generated>
	<cdecl: void 'SetWindowState' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> setWindowTitle: title [
	"Set title for window
	title - const char *"
	<generated>
	<cdecl: void 'SetWindowTitle' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> showCursor [
	"Shows cursor
"
	<generated>
	<cdecl: void 'ShowCursor' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> startAutomationEventRecording [
	"Start recording automation events (AutomationEventList must be set)
"
	<generated>
	<cdecl: void 'StartAutomationEventRecording' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> stopAutomationEventRecording [
	"Stop recording automation events
"
	<generated>
	<cdecl: void 'StopAutomationEventRecording' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> swapScreenBuffer [
	"Swap back buffer with front buffer (screen drawing)
"
	<generated>
	<cdecl: void 'SwapScreenBuffer' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> takeScreenshotFileName: fileName [
	"Takes a screenshot of current screen (filename extension defines format)
	fileName - const char *"
	<generated>
	<cdecl: void 'TakeScreenshot' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textAppendText: text append: append position: position [
	"Append text at specific position and move cursor!
	text - char *
	append - const char *
	position - int *"
	<generated>
	<cdecl: void 'TextAppend' (char8_t*, char8_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textCopyDst: dst src: src [
	"Copy one string to another, returns bytes copied
	dst - char *
	src - const char *"
	<generated>
	<cdecl: int32_t 'TextCopy' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textFindIndexText: text find: find [
	"Find first text occurrence within a string
	text - const char *
	find - const char *"
	<generated>
	<cdecl: int32_t 'TextFindIndex' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textInsertText: text insert: insert position: position [
	"Insert text in a position (WARNING: memory must be freed!)
	text - const char *
	insert - const char *
	position - int"
	<generated>
	<cdecl: char8_t* 'TextInsert' (char8_t*, char8_t*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textIsEqualText1: text1 text2: text2 [
	"Check if two text string are equal
	text1 - const char *
	text2 - const char *"
	<generated>
	<cdecl: bool 'TextIsEqual' (char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textJoinTextList: textList count: count delimiter: delimiter [
	"Join text strings with delimiter
	textList - char **
	count - int
	delimiter - const char *"
	<generated>
	<cdecl: char8_t* 'TextJoin' (void*, int32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textLengthText: text [
	"Get text length, checks for '\0' ending
	text - const char *"
	<generated>
	<cdecl: uint32_t 'TextLength' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textReplaceText: text replace: replace by: by [
	"Replace text string (WARNING: memory must be freed!)
	text - const char *
	replace - const char *
	by - const char *"
	<generated>
	<cdecl: char8_t* 'TextReplace' (char8_t*, char8_t*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textSplitText: text delimiter: delimiter count: count [
	"Split text into multiple strings
	text - const char *
	delimiter - char
	count - int *"
	<generated>
	<cdecl: void* 'TextSplit' (char8_t*, char8_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textSubtext: text position: position length: length [
	"Get a piece of a text string
	text - const char *
	position - int
	length - int"
	<generated>
	<cdecl: char8_t* 'TextSubtext' (char8_t*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToCamelText: text [
	"Get Camel case notation version of provided string
	text - const char *"
	<generated>
	<cdecl: char8_t* 'TextToCamel' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToFloatText: text [
	"Get float value from text
	text - const char *"
	<generated>
	<cdecl: float 'TextToFloat' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToIntegerText: text [
	"Get integer value from text
	text - const char *"
	<generated>
	<cdecl: int32_t 'TextToInteger' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToLowerText: text [
	"Get lower case version of provided string
	text - const char *"
	<generated>
	<cdecl: char8_t* 'TextToLower' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToPascalText: text [
	"Get Pascal case notation version of provided string
	text - const char *"
	<generated>
	<cdecl: char8_t* 'TextToPascal' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToSnakeText: text [
	"Get Snake case notation version of provided string
	text - const char *"
	<generated>
	<cdecl: char8_t* 'TextToSnake' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> textToUpperText: text [
	"Get upper case version of provided string
	text - const char *"
	<generated>
	<cdecl: char8_t* 'TextToUpper' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> toggleBorderlessWindowed [
	"Toggle window state: borderless windowed, resizes window to match monitor resolution
"
	<generated>
	<cdecl: void 'ToggleBorderlessWindowed' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> toggleFullscreen [
	"Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
"
	<generated>
	<cdecl: void 'ToggleFullscreen' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadAutomationEventList: list [
	"Unload automation events list from file
	list - AutomationEventList"
	<generated>
	<cdecl: void 'UnloadAutomationEventList' (RlAutomationEventList)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadCodepoints: codepoints [
	"Unload codepoints data from memory
	codepoints - int *"
	<generated>
	<cdecl: void 'UnloadCodepoints' (int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadDirectoryFiles: files [
	"Unload filepaths
	files - FilePathList"
	<generated>
	<cdecl: void 'UnloadDirectoryFiles' (RlFilePathList)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadDroppedFiles: files [
	"Unload dropped filepaths
	files - FilePathList"
	<generated>
	<cdecl: void 'UnloadDroppedFiles' (RlFilePathList)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadFileData: data [
	"Unload file data allocated by LoadFileData()
	data - unsigned char *"
	<generated>
	<cdecl: void 'UnloadFileData' (uchar8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadFileText: text [
	"Unload file text data allocated by LoadFileText()
	text - char *"
	<generated>
	<cdecl: void 'UnloadFileText' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadFont: font [
	"Unload font from GPU memory (VRAM)
	font - Font"
	<generated>
	<cdecl: void 'UnloadFont' (RlFont)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadFontDataGlyphs: glyphs glyphCount: glyphCount [
	"Unload font chars info data (RAM)
	glyphs - GlyphInfo *
	glyphCount - int"
	<generated>
	<cdecl: void 'UnloadFontData' (RlGlyphInfo*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadImage: image [
	"Unload image from CPU memory (RAM)
	image - Image"
	<generated>
	<cdecl: void 'UnloadImage' (RlImage)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadImageColors: colors [
	"Unload color data loaded with LoadImageColors()
	colors - Color *"
	<generated>
	<cdecl: void 'UnloadImageColors' (RlColor*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadImagePaletteColors: colors [
	"Unload colors palette loaded with LoadImagePalette()
	colors - Color *"
	<generated>
	<cdecl: void 'UnloadImagePalette' (RlColor*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadMaterial: material [
	"Unload material from GPU memory (VRAM)
	material - Material"
	<generated>
	<cdecl: void 'UnloadMaterial' (RlMaterial)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadMesh: mesh [
	"Unload mesh data from CPU and GPU
	mesh - Mesh"
	<generated>
	<cdecl: void 'UnloadMesh' (RlMesh)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadModel: model [
	"Unload model (including meshes) from memory (RAM and/or VRAM)
	model - Model"
	<generated>
	<cdecl: void 'UnloadModel' (RlModel)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadModelAnimationAnim: anim [
	"Unload animation data
	anim - ModelAnimation"
	<generated>
	<cdecl: void 'UnloadModelAnimation' (RlModelAnimation)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadModelAnimations: animations animCount: animCount [
	"Unload animation array data
	animations - ModelAnimation *
	animCount - int"
	<generated>
	<cdecl: void 'UnloadModelAnimations' (RlModelAnimation*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadRandomSequence: sequence [
	"Unload random values sequence
	sequence - int *"
	<generated>
	<cdecl: void 'UnloadRandomSequence' (int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadRenderTextureTarget: target [
	"Unload render texture from GPU memory (VRAM)
	target - RenderTexture2D"
	<generated>
	<cdecl: void 'UnloadRenderTexture' (RlRenderTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadShader: shader [
	"Unload shader from GPU memory (VRAM)
	shader - Shader"
	<generated>
	<cdecl: void 'UnloadShader' (RlShader)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadTexture: texture [
	"Unload texture from GPU memory (VRAM)
	texture - Texture2D"
	<generated>
	<cdecl: void 'UnloadTexture' (RlTexture)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadUTF8Text: text [
	"Unload UTF-8 text encoded from codepoints array
	text - char *"
	<generated>
	<cdecl: void 'UnloadUTF8' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadVrStereoConfig: config [
	"Unload VR stereo config
	config - VrStereoConfig"
	<generated>
	<cdecl: void 'UnloadVrStereoConfig' (RlVrStereoConfig)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadWave: wave [
	"Unload wave data
	wave - Wave"
	<generated>
	<cdecl: void 'UnloadWave' (RlWave)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> unloadWaveSamples: samples [
	"Unload samples data loaded with LoadWaveSamples()
	samples - float *"
	<generated>
	<cdecl: void 'UnloadWaveSamples' (float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateCamera: camera mode: mode [
	"Update camera position for selected mode
	camera - Camera *
	mode - int"
	<generated>
	<cdecl: void 'UpdateCamera' (RlCamera3D*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateCameraProCamera: camera movement: movement rotation: rotation zoom: zoom [
	"Update camera movement/rotation
	camera - Camera *
	movement - Vector3
	rotation - Vector3
	zoom - float"
	<generated>
	<cdecl: void 'UpdateCameraPro' (RlCamera3D*, RlVector3, RlVector3, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateMeshBufferMesh: mesh index: index data: data dataSize: dataSize offset: offset [
	"Update mesh vertex data in GPU for a specific buffer index
	mesh - Mesh
	index - int
	data - const void *
	dataSize - int
	offset - int"
	<generated>
	<cdecl: void 'UpdateMeshBuffer' (RlMesh, int32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateModelAnimationBonesModel: model anim: anim frame: frame [
	"Update model animation mesh bone matrices (GPU skinning)
	model - Model
	anim - ModelAnimation
	frame - int"
	<generated>
	<cdecl: void 'UpdateModelAnimationBones' (RlModel, RlModelAnimation, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateModelAnimationModel: model anim: anim frame: frame [
	"Update model animation pose (CPU)
	model - Model
	anim - ModelAnimation
	frame - int"
	<generated>
	<cdecl: void 'UpdateModelAnimation' (RlModel, RlModelAnimation, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateTexture: texture pixels: pixels [
	"Update GPU texture with new data
	texture - Texture2D
	pixels - const void *"
	<generated>
	<cdecl: void 'UpdateTexture' (RlTexture, void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> updateTextureRecTexture: texture rec: rec pixels: pixels [
	"Update GPU texture rectangle with new data
	texture - Texture2D
	rec - Rectangle
	pixels - const void *"
	<generated>
	<cdecl: void 'UpdateTextureRec' (RlTexture, RlRectangle, void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> uploadMesh: mesh dynamic: dynamic [
	"Upload mesh vertex data in GPU and provide VAO/VBO ids
	mesh - Mesh *
	dynamic - bool"
	<generated>
	<cdecl: void 'UploadMesh' (RlMesh*, bool)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> waitTimeSeconds: seconds [
	"Wait for some time (halt program execution)
	seconds - double"
	<generated>
	<cdecl: void 'WaitTime' (double)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> waveCopyWave: wave [
	"Copy a wave to a new wave
	wave - Wave"
	<generated>
	<cdecl: RlWave 'WaveCopy' (RlWave)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> waveCropWave: wave initFrame: initFrame finalFrame: finalFrame [
	"Crop a wave to defined frames range
	wave - Wave *
	initFrame - int
	finalFrame - int"
	<generated>
	<cdecl: void 'WaveCrop' (RlWave*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> waveFormatWave: wave sampleRate: sampleRate sampleSize: sampleSize channels: channels [
	"Convert wave data to desired format
	wave - Wave *
	sampleRate - int
	sampleSize - int
	channels - int"
	<generated>
	<cdecl: void 'WaveFormat' (RlWave*, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/13/2025 17:48'
}
RlFunctions >> windowShouldClose [
	"Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
"
	<generated>
	<cdecl: bool 'WindowShouldClose' ()>
	^ self externalCallFailed
]
