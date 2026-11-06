Class {
	#name : #SRMorphicProject,
	#superclass : #MorphicProject,
	#instVars : [
		'startSemaphore'
	],
	#category : #'SqueakXR-Morphic'
}

{
	#category : #enter,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
}
SRMorphicProject >> finalEnterActions: leavingProject [

	super finalEnterActions: leavingProject.
	SRToolSet activate
]

{
	#category : #enter,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
}
SRMorphicProject >> finalExitActions: enteringProject [

	SRToolSet deactivate.
	super finalExitActions: enteringProject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:08'
}
SRMorphicProject >> initialize [

	super initialize.
	self installPasteUpAsWorld: (SRPasteUpMorph new).
	startSemaphore := Semaphore new.
	self world
		when: #aboutToEnterWorld
		send: #signalStart
		to: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:37'
}
SRMorphicProject >> showZoom [

	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:09'
}
SRMorphicProject >> signalStart [

	self world color: Color midnight.
	startSemaphore signal
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 7/28/2026 16:19'
}
SRMorphicProject >> subProjects [
	
	
	
	"#TODO find the real issue. "
	"world ifNil: [^ Array new]."
	
	^ super subProjects
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:56'
}
SRMorphicProject >> waitForStart [

	startSemaphore wait
]
