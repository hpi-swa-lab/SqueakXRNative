"
SRMenuContext is what a menu action receives: everything it needs to know about where and why it was invoked.

	world			the SRWorld the menu was opened in
	position		where the menu is, i.e. the natural spawn point for new objects
	viewerPosition	the user's head/camera position (menus face it)
	target			the object whose context menu this is, nil for the world menu
	menu			the SRMenu being built or the one that was clicked

Actions declared with <srMenu:label:priority:> are performed with #withEnoughArguments:, so an action method may take this context or take nothing at all.
"
Class {
	#name : #SRMenuContext,
	#superclass : #Object,
	#instVars : [
		'world',
		'position',
		'viewerPosition',
		'target',
		'menu'
	],
	#category : #'SqueakXR-Menus',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext class >> world: aWorld position: aVector viewer: viewerVector target: anObjectOrNil [
	^ self new
		setWorld: aWorld
		position: aVector
		viewerPosition: viewerVector
		target: anObjectOrNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> menu [
	^ menu
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> menu: anSRMenu [
	menu := anSRMenu
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> position [
	"Where the menu is; the natural place to put something the action spawns."
	^ position
]

{
	#category : #printing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' target: '; print: target
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> setWorld: aWorld position: aVector viewerPosition: viewerVector target: anObjectOrNil [
	world := aWorld.
	position := aVector.
	viewerPosition := viewerVector.
	target := anObjectOrNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> target [
	"The object whose context menu this is; nil for the world menu."
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> viewerPosition [
	^ viewerPosition
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuContext >> world [
	^ world
]
