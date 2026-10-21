Class {
	#name : #SRPooledObjectTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Pool'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:40'
}
SRPooledObjectTest >> setUp [

	"SRPooledObject class>>createPool asserts on a nil internalClass, so the fixture
	is not usable until one is set."

	super setUp.
	SRDummyPooledObject internalClass: RlVector3.
	SRDummyPooledObject resetPool.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:40'
}
SRPooledObjectTest >> testCreateInstance [

	| instance |
	instance := SRDummyPooledObject new.
	self assert: instance internalObject class == RlVector3.
	self assert: instance internalIndex equals: 1.
	self assert: instance internalPool == SRDummyPooledObject pool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:40'
}
SRPooledObjectTest >> testEachInstanceGetsItsOwnSlot [

	| instances |
	instances := (1 to: SRDummyPooledObject poolSize) collect: [:i | SRDummyPooledObject new].
	self assert: (instances collect: [:each | each internalIndex]) asArray
		equals: (1 to: SRDummyPooledObject poolSize) asArray.
	self assert: (instances collect: [:each | each internalObject]) asSet size
		equals: SRDummyPooledObject poolSize.
]
