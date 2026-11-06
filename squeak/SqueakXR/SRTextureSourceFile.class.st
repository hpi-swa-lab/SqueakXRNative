"
Abstract texture source that loads its texture from an image file.
"
Class {
	#name : #SRTextureSourceFile,
	#superclass : #SRTextureSource,
	#instVars : [
		'path'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:55'
}
SRTextureSourceFile class >> path: aString [

	^ self new path: aString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRTextureSourceFile >> createInternalTexture [

	SRRenderer assertContext.
	self assert: path notNil.
	self unload.
	^ internalTexture := self loadInternalTexture
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRTextureSourceFile >> loadInternalTexture [

	self subclassResponsibility.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:55'
}
SRTextureSourceFile >> path [

	^ path
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:55'
}
SRTextureSourceFile >> path: aString [

	path := aString.
	self notifyTextureChanged.
]
