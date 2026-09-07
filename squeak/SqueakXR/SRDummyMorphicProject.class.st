"
Stands in for the SRMorphicProject an SRWorld runs in, for tests.

SRWorld only ever asks its project for #world, and SRPasteUpMorph>>beWorldForProject: ignores the project it is passed, so nothing here needs to be a real Project. That matters: instantiating a real one registers it in Project>>allProjects and creates a ChangeSet.
"
Class {
	#name : #SRDummyMorphicProject,
	#superclass : #Object,
	#instVars : [
		'world'
	],
	#category : #'SqueakXR-Tests-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 15:31'
}
SRDummyMorphicProject >> initialize [

	super initialize.
	world := SRPasteUpMorph new beWorldForProject: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:31'
}
SRDummyMorphicProject >> world [

	^ world
]
