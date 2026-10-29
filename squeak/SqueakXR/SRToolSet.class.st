"
The tool set while an SRMorphicProject is current. Debugs errors that an SRFrame can skip without halting the world.
"
Class {
	#name : #SRToolSet,
	#superclass : #StandardToolSet,
	#classInstVars : [
		'previousToolSet'
	],
	#category : #'SqueakXR-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #activation,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:09'
}
SRToolSet class >> activate [

	ToolSet default = self ifTrue: [^ self].
	previousToolSet := ToolSet default: self
]

{
	#category : #completion,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:08'
}
SRToolSet class >> codeCompletionAround: aBlock textMorph: aTextMorph keyStroke: evt [
	"Keep the code completion of the replaced tool set (e.g. ECToolSet), which StandardToolSet lacks."

	^ previousToolSet
		ifNil: [super codeCompletionAround: aBlock textMorph: aTextMorph keyStroke: evt]
		ifNotNil: [:toolSet | toolSet codeCompletionAround: aBlock textMorph: aTextMorph keyStroke: evt]
]

{
	#category : #activation,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:09'
}
SRToolSet class >> deactivate [

	ToolSet default = self ifFalse: [^ self].
	ToolSet default: previousToolSet.
	ToolSet unregister: self.
	previousToolSet := nil
]

{
	#category : #debugging,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:09'
}
SRToolSet class >> handleError: anError [

	| world |
	world := SRWorld current.
	(world notNil
		and: [world worldProcess = Processor activeProcess
		and: [SRIsFrameContinuableVariable value]])
			ifFalse: [^ super handleError: anError].
	
	world spawnNewWorldProcess.
	super handleError: anError.
	"Resumed from the debugger, but the new process already runs the world."
	Processor terminateActive
]
