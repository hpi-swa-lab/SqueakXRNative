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
	#'squeak_changestamp' : 'lege 9/29/2025 18:21'
}
SRSceneTreeInspector >> buildTreeSpecWith: aBuilder [

	| treeSpec |
	treeSpec := aBuilder pluggableTreeSpec new.
	treeSpec
		model: self;
		getSelected: #currentSelection;
		setSelected: #currentSelection:;
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
	#'squeak_changestamp' : 'lege 10/6/2025 13:19'
}
SRSceneTreeInspector >> continueStepping [

	self currentSelection ifNotNil: [:object | object continueStepping]
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> currentSelectedPath [

	^ currentSelection
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> currentSelectedPath: aSRObjectPath [

	currentSelection := aSRObjectPath.
	self changed: #propertiesOfCurrentSelection.
	self changed: #currentSelection
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> currentSelection [

	^ currentSelection
		ifNil: [self root]
		ifNotNil: [currentSelection]
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> currentSelection: aSRObject [

	self currentSelection = aSRObject ifTrue: [^ self].
	currentSelection := aSRObject.
	self changed: #currentSelection;
		changed: #propertiesOfCurrentSelection
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
	#'squeak_changestamp' : 'lege 9/29/2025 18:42'
}
SRSceneTreeInspector >> doItReceiver [

	^ self currentSelection
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

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> key: aChar from: view event: event [

	event anyModifierKeyPressed ifFalse: [^ false].

	aChar == $i ifTrue: [self currentSelection inspect. ^ true].
	aChar == $I ifTrue: [self currentSelection explore. ^ true].
	
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
	#'squeak_changestamp' : 'lege 10/8/2025 12:34'
}
SRSceneTreeInspector >> propertiesOfCurrentSelection [

	| selection |
	selection := self currentSelection.
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

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> root [

	^ root
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> root: aSRObject [

	root := aSRObject
]

{ #category : #'as yet unclassified' }
SRSceneTreeInspector >> roots [

	^ { self root }
]
