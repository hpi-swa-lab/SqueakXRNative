"
Builds fields without a world: SRCubeField class>>show: needs one, so the
tests go through #setCount:cubeClass: instead. The cube class is a class
variable, so it is saved and restored per test.
"
Class {
	#name : #SRCubeFieldTest,
	#superclass : #TestCase,
	#instVars : [
		'savedClass',
		'savedWires',
		'savedAnimating'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeFieldTest >> fieldOf: aCount [
	^ SRCubeField new setCount: aCount cubeClass: SRCubeField cubeClass.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> setUp [
	super setUp.
	savedClass := SRCubeField cubeClass.
	savedWires := SRCubeField drawWires.
	savedAnimating := SRCubeField animating.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> tearDown [
	SRCubeField cubeClass: savedClass.
	SRCubeField drawWires: savedWires.
	SRCubeField animating: savedAnimating.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testAnimationLeavesTheButtonAlone [
	| field |
	field := self fieldOf: 20.
	field animating: true.
	field step: 0.1.
	self assert: Quaternion identity equals: field button localRotation.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testButtonLabelNamesWhatItRemoves [
	SRCubeField cubeClass: SRFastCube.
	self assert: 'remove 3000 SRFastCube' equals: (self fieldOf: 3000) button label.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testButtonRaycastRemovesTheField [
	| removed field |
	removed := false.
	field := self fieldOf: 10.
	field button action: [removed := true].
	field button onRaycast: nil.
	self assert: removed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testCubeClassFollowsTheSetting [
	SRCubeField cubeClass: SRCube.
	self assert: SRCube equals: (self fieldOf: 10) children first class.
	SRCubeField cubeClass: SRFastCube.
	self assert: SRFastCube equals: (self fieldOf: 10) children first class.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testCubesStandInFrontOfTheButton [
	"Walk-in means the lattice is ahead and the sign is between you and it."

	| field |
	field := self fieldOf: 1000.
	self assert: (field children allSatisfy: [:each |
		each isCube not or: [each position z < field button position z]]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeFieldTest >> testHoldsTheRequestedCubes [
	| field cubes |
	SRCubeField cubeClass: SRFastCube.
	field := self fieldOf: 500.
	cubes := field children select: [:each | each isCube].
	self assert: 500 equals: cubes size.
	self assert: (cubes allSatisfy: [:each | each isKindOf: SRFastCube]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testMenuOffersEveryThousand [
	| labels |
	SRMenuRegistry current updateRegistry.
	labels := (SRMenuRegistry current directItemsUnder: #(world profile benchmarks cubes))
		collect: [:each | each labelIn: nil target: nil].
	1 to: 10 do: [:k |
		self assert: (labels includes: (k * 1000) printString)].
	self assert: (labels includes: 'remove').
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRCubeFieldTest >> testMenuTogglesTheCubeClass [
	SRCubeField cubeClass: SRCube.
	self assert: 'class: SRCube' equals: SRCubeField xrMenuClassLabel.
	SRCubeField xrMenuToggleClass: nil.
	self assert: SRFastCube equals: SRCubeField cubeClass.
	self assert: 'class: SRFastCube' equals: SRCubeField xrMenuClassLabel.
	SRCubeField xrMenuToggleClass: nil.
	self assert: SRCube equals: SRCubeField cubeClass.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testMenuTogglesWiresAndAnimation [
	SRCubeField drawWires: true.
	self assert: 'wires: on' equals: SRCubeField xrMenuWiresLabel.
	SRCubeField xrMenuToggleWires: nil.
	self assert: 'wires: off' equals: SRCubeField xrMenuWiresLabel.
	SRCubeField animating: false.
	self assert: 'animate: off' equals: SRCubeField xrMenuAnimationLabel.
	SRCubeField xrMenuToggleAnimation: nil.
	self assert: 'animate: on' equals: SRCubeField xrMenuAnimationLabel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testOneStepForTheWholeField [
	"The cubes must not step themselves: SRFrame builds the stepped-object list
	per frame and N stepping cubes is N entries in it."

	| field |
	field := self fieldOf: 5.
	self assert: field isStepping.
	self assert: (field children noneSatisfy: [:each | each isStepping]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testStepRotatesEveryCubeWhenAnimating [
	| field cubes before |
	field := self fieldOf: 20.
	cubes := field children select: [:each | each isCube].
	before := cubes collect: [:each | each localRotation].
	field animating: false.
	field step: 0.1.
	self assert: before equals: (cubes collect: [:each | each localRotation]).
	field animating: true.
	field step: 0.1.
	self assert: (cubes allSatisfy: [:each | each localRotation ~= Quaternion identity]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testWiresSettingReachesEveryCube [
	| field cubes |
	SRCubeField drawWires: false.
	field := self fieldOf: 20.
	cubes := field children select: [:each | each isCube].
	self assert: (cubes noneSatisfy: [:each | each drawWires]).
	field drawWires: true.
	self assert: (cubes allSatisfy: [:each | each drawWires]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRCubeFieldTest >> testWiresTogglesForBothCubeClasses [
	{SRCube. SRFastCube} do: [:each |
		SRCubeField cubeClass: each.
		SRCubeField drawWires: false.
		self deny: (self fieldOf: 5) children first drawWires].
]
