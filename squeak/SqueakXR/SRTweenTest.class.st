"
Tests SRTween.
"
Class {
	#name : #SRTweenTest,
	#superclass : #TestCase,
	#instVars : [
		'values'
	],
	#category : #'SqueakXR-Tests-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> setUp [

	super setUp.
	values := OrderedCollection new
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testDurationIsADuration [

	| tween |
	tween := (self tweenFrom: 0 to: 10)
		duration: 200 milliSeconds;
		start;
		yourself.
	tween step: 0.1.
	self assert: (values last closeTo: 5)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTweenTest >> testEaseShortcutsSetTheEase [

	| tween |
	tween := SRTween new.
	{#easeIn -> #in. #easeOut -> #out. #easeInOut -> #inOut. #easeOutIn -> #outIn} do: [:each |
		self assert: (tween perform: each key) == tween.
		self assert: tween ease equals: each value]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testOnlySteppingWhileRunning [

	| tween |
	tween := self tweenFrom: 0 to: 10.
	self deny: tween isStepping.
	tween start.
	self assert: tween isStepping.
	tween step: 2.
	self deny: tween isStepping
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testRestartingBeginsFromTheStart [

	| tween |
	tween := (self tweenFrom: 0 to: 10) start; yourself.
	tween step: 0.75.
	tween stop; start.
	tween step: 0.25.
	self assert: values last equals: 2.5
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTweenTest >> testShortcutsChainLikeTheSetters [

	| tween |
	tween := (self tweenFrom: 0 to: 100) transitionQuad; easeIn; start; yourself.
	tween step: 0.5.
	self assert: values last equals: 25.0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testStepSendsTheInterpolatedValue [

	| tween |
	tween := (self tweenFrom: 0 to: 10) start; yourself.
	tween step: 0.25.
	tween step: 0.25.
	self assert: values asArray equals: #(2.5 5.0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testTheLastValueIsExactlyTheEnd [

	| start end tween |
	start := Quaternion angle: 10 axis: Vector3 up.
	end := Quaternion angle: 80 axis: Vector3 right.
	tween := (self tweenFrom: start to: end) start; yourself.
	tween step: 0.5.
	tween step: 5.
	self assert: values last == end
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> testTheTransitionAndEaseShapeTheValue [

	| tween |
	tween := (self tweenFrom: 0 to: 100)
		transition: SRTransition quad;
		ease: #in;
		start;
		yourself.
	tween step: 0.5.
	self assert: values last equals: 25.0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTweenTest >> testThereIsAnEaseShortcutForEveryEase [

	SRTransition eases do: [:ease |
		self assert: (SRTween includesSelector: ('ease', ease first asUppercase asString, ease allButFirst) asSymbol)]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTweenTest >> testTransitionShortcutsSetTheTransition [

	| tween |
	tween := SRTween new.
	((SRTransition class organization listAtCategoryNamed: 'instance creation') copyWithout: #all) do: [:name |
		self assert: (tween perform: ('transition', name first asUppercase asString, name allButFirst) asSymbol) == tween.
		self assert: tween transition class equals: (SRTransition perform: name) class]
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTweenTest >> tweenFrom: aValue to: anotherValue [

	^ SRTween new
		from: aValue to: anotherValue;
		duration: 1 seconds;
		transition: SRTransition linear;
		target: [:each | values add: each];
		yourself
]
