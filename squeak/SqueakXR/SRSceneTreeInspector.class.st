Class {
	#name : #SRSceneTreeInspector,
	#superclass : #Model,
	#instVars : [
		'root',
		'currentSelection',
		'expression'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRSceneTreeInspector class >> openOn: aSRObject [

	^ self new
		root: aSRObject;
		build
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/31/2026 15:01'
}
SRSceneTreeInspector class >> openOnCurrentWorld [

	^ self openOn: self currentXRWorld
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:21'
}
SRSceneTreeInspector class >> xrMenuOpenOn: aMenu target: anObject [
	<xrMenu: #(object) label: 'Scene Tree' priority: 200>
	^ self openOn: anObject
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:38'
}
SRSceneTreeInspector class >> xrMenuOpenOnWorld: aMenu [
	<xrMenu: #(world tools) label: 'Scene Tree' priority: 210>
	^ self openOn: aMenu world
]

{ #category : #toolbuilder }
SRSceneTreeInspector >> build [

	| builder window |
	builder := ToolBuilder default.
	window := self buildWith: builder.
	builder open: window.
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 10/6/2025 15:21'
}
SRSceneTreeInspector >> buildButtonPanel: aBuilder [

	| continueSteppingButton continueRenderingButton spacer |
	continueSteppingButton := aBuilder pluggableButtonSpec new
		model: self;
		label: 'Continue Stepping';
		action: #continueStepping.
	
	continueRenderingButton := aBuilder pluggableButtonSpec new
		model: self;
		label: 'Continue Rendering';
		action: #continueRendering.
	
	spacer := aBuilder pluggableSpacerSpec new.
	
	^ aBuilder pluggablePanelSpec new
		layout: #horizontal;
		spacing: (-1 * RealEstateAgent scaleFactor) truncated;
		children: {continueSteppingButton. spacer. continueRenderingButton}
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:24'
}
SRSceneTreeInspector >> buildCodePaneWith: aBuilder [

	| treeSpec |
	treeSpec := aBuilder pluggableCodePaneSpec new.
	treeSpec
		model: self;
		getText: #expression;
		editText: #expression:;
		menu: #codePaneMenu:shifted:;
		help: 'Evaluate expressions for the selected object...'.
	
	^ treeSpec
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:21'
}
SRSceneTreeInspector >> buildListSpecWith: aBuilder [

	| listSpec |
	listSpec := aBuilder pluggableListSpec new.
	listSpec 
		model: self;
		list: #propertiesOfCurrentSelection. 
	^ listSpec
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 8/3/2026 15:48'
}
SRSceneTreeInspector >> buildTreeSpecWith: aBuilder [

	| treeSpec |
	treeSpec := aBuilder pluggableTreeSpec new.
	treeSpec
		model: self;
		getSelectedPath: #currentSelectedPath;
		setSelectedPath: #currentSelectedPath:;
		getChildren: #childrenOf:;
		roots: #roots;
		label: #labelOf:;
		autoDeselect: false;
		keyPress: #key:from:event:.
	
	^ treeSpec
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 10/6/2025 13:36'
}
SRSceneTreeInspector >> buildWith: aBuilder [

	^ self buildWindowWith: aBuilder specs: {
		(0.0 @ 0.0 corner: 0.5 @ 1.0) -> [self buildTreeSpecWith: aBuilder].
		(0.5 @ 0.0 corner: 1.0 @ 0.75) -> [self buildListSpecWith: aBuilder].
		(0.5 @ 0.75 corner: 1.0 @ 0.8) -> [self buildButtonPanel: aBuilder].
		(0.5 @ 0.8 corner: 1.0 @ 1.0) -> [self buildCodePaneWith: aBuilder]}
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> childrenOf: aSRObject [

	^ aSRObject children
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:24'
}
SRSceneTreeInspector >> codePaneMenu: aMenu shifted: shifted [
	^ StringHolder codePaneMenu: aMenu shifted: shifted

]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 10/6/2025 15:21'
}
SRSceneTreeInspector >> continueRendering [

	self currentSelection ifNotNil: [:object | object continueRendering]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 8/4/2026 11:13'
}
SRSceneTreeInspector >> continueStepping [

	self hasSelection ifTrue: [self currentSelection last continueStepping]
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> currentSelectedPath [

	^ currentSelection
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/3/2026 14:48'
}
SRSceneTreeInspector >> currentSelectedPath: aSRObjectPath [

	| reverseObjectPath |
	reverseObjectPath := aSRObjectPath ifNotNil: [aSRObjectPath reverse].
	currentSelection = reverseObjectPath ifTrue: [^ self].
	
	currentSelection := reverseObjectPath.
	self changed: #propertiesOfCurrentSelection;
		changed: #currentSelectedPath.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/31/2026 17:06'
}
SRSceneTreeInspector >> currentSelection [

	^ currentSelection
		ifNil: [{self root}]
		ifNotNil: [currentSelection]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:42'
}
SRSceneTreeInspector >> doItContext [

	^nil
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 8/3/2026 13:45'
}
SRSceneTreeInspector >> doItReceiver [

	^ self currentSelection
		ifEmpty: [nil]
		ifNotEmpty: [:selection | selection last]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:24'
}
SRSceneTreeInspector >> expression [

	^ expression
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'lege 9/29/2025 18:24'
}
SRSceneTreeInspector >> expression: aString [

	expression := aString.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/31/2026 17:33'
}
SRSceneTreeInspector >> hasSelection [

	^ currentSelection notNil and: [currentSelection notEmpty]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/31/2026 15:07'
}
SRSceneTreeInspector >> key: aChar from: view event: event [

	event anyModifierKeyPressed ifFalse: [^ false].

	aChar == $i ifTrue: [self currentSelection inspect. ^ true].
	aChar == $I ifTrue: [self currentSelection explore. ^ true].
	aChar = $b ifTrue: [ToolSet browseClass: self currentSelection class. ^ true].
	
	^ false
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> labelOf: aSRObject [

	^ ('{1} ({2})') format: {
		aSRObject name.
		aSRObject class
	}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/4/2026 11:14'
}
SRSceneTreeInspector >> propertiesOfCurrentSelection [

	| selection |
	self hasSelection ifFalse: [^ {}].
	
	selection := self currentSelection last.
	^ {
		selection name.
		'Children: {1}' format: {selection childCount}.
		'Is Stepping: ', selection isStepping.
		'Is Rendering: ', selection isRendering.
		'Local translation'.
		'    x: ', selection localTranslation x.
		'    y: ', selection localTranslation y.
		'    z: ', selection localTranslation z.
		'Local rotation'.
		'    axis x: ', selection localRotation axis x.
		'    axis y: ', selection localRotation axis y.
		'    axis z: ', selection localRotation axis z.
		'    angle: ', selection localRotation angle.
		'Local scale'.
		'    x: ', selection localScale x.
		'    y: ', selection localScale y.
		'    z: ', selection localScale z.
		'Global translation'.
		'    x: ', selection globalTranslation x.
		'    y: ', selection globalTranslation y.
		'    z: ', selection globalTranslation z.
		'Global rotation'.
		'    axis x: ', selection globalRotation axis x.
		'    axis y: ', selection globalRotation axis y.
		'    axis z: ', selection globalRotation axis z.
		'    angle: ', selection globalRotation angle.
		'Global scale'.
		'    x: ', selection globalScale x.
		'    y: ', selection globalScale y.
		'    z: ', selection globalScale z.
	}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/3/2026 15:46'
}
SRSceneTreeInspector >> restoreSelection [

	(currentSelection isNil or: [currentSelection isEmpty]) ifTrue: [^ self].
	self selectionPathIsLive ifFalse: [
		currentSelection := nil.
		self changed: #propertiesOfCurrentSelection].
	self changed: #currentSelectedPath.
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> root [

	^ root
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/31/2026 15:02'
}
SRSceneTreeInspector >> root: aSRObject [

	root ifNotNil: [root removeDependent: self].
	root := aSRObject.
	root addDependent: self.
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> roots [

	^ { self root }
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/3/2026 15:42'
}
SRSceneTreeInspector >> selectionPathIsLive [

	| leaf |
	leaf := self currentSelectedPath last.
	^ self roots anySatisfy: [:ea | leaf hasAncestor: ea]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/3/2026 15:45'
}
SRSceneTreeInspector >> update: aSymbol with: info [

	(#(descendantAdded descendantRemoved childAdded childRemoved) includes: aSymbol)
		ifFalse: [^ self].

	self changed: #roots.
	self restoreSelection.
]
