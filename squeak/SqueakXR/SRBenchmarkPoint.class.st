"
One measured point of a benchmark curve: the parameter it was taken at, the wall
time, the reported value, and the VM counter deltas across the measured region.

`counters` is keyed by vmParameter index, so a reader needs the index table in
SRBenchmark class>>counterIndices to interpret it.
"
Class {
	#name : #SRBenchmarkPoint,
	#superclass : #Object,
	#instVars : [
		'parameter',
		'iterations',
		'micros',
		'value',
		'counters',
		'details'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> bytesAllocated [
	^ self counterAt: 34
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> counterAt: vmParameterIndex [
	^ self counters at: vmParameterIndex ifAbsent: [0]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> counters [
	^ counters ifNil: [counters := Dictionary new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> counters: aDictionary [
	counters := aDictionary.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:15'
}
SRBenchmarkPoint >> detailAt: aKey [
	^ self details at: aKey ifAbsent: [0]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:15'
}
SRBenchmarkPoint >> detailAt: aKey put: aValue [
	^ self details at: aKey put: aValue
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:15'
}
SRBenchmarkPoint >> details [
	"Free-form derived figures a subclass wants in its own report columns. Kept on
	the point rather than on the benchmark because the benchmark is reused across
	every parameter and would only remember the last."
	^ details ifNil: [details := Dictionary new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> gcMicros [
	"p10 counts whole milliseconds, so a sub-millisecond scavenge shows up only
	once many of them have accumulated."
	^ (self counterAt: 10) * 1000
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> iterations [
	^ iterations ifNil: [1]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> iterations: anInteger [
	iterations := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> micros [
	^ micros ifNil: [0]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> micros: anInteger [
	micros := anInteger.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> parameter [
	^ parameter
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> parameter: anObject [
	parameter := anObject.
]

{
	#category : #printing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> printOn: aStream [
	aStream nextPutAll: self class name; nextPut: $(.
	parameter printOn: aStream.
	aStream nextPutAll: ' -> '.
	self value printOn: aStream.
	aStream nextPut: $).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> scavenges [
	^ self counterAt: 9
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> tenures [
	^ self counterAt: 11
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> value [
	^ value ifNil: [self micros / self iterations]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:11'
}
SRBenchmarkPoint >> value: aNumber [
	value := aNumber.
]
