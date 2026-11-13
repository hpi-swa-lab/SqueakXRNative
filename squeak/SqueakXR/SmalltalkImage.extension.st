Extension { #name : #SmalltalkImage }

{
	#category : #'*SqueakXR-snapshot and quit',
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 14:06'
}
SmalltalkImage >> logStartUpErrorsOf: aClassName during: aBlock [
	"Startup runs before any UI exists: an error here would end the startup sequence
	invisibly and leave every later class in the list uninitialized."

	^ aBlock
		on: Error
		do: [:error |
			[FileStream stdout
				nextPutAll: 'startUp: of ', aClassName, ' failed: ', error description; lf;
				nextPutAll: error signalerContext shortStack; lf;
				flush]
					on: Error
					do: [:ignored | ].
			nil]
]

{
	#category : #'*SqueakXR-snapshot and quit',
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 14:06'
}
SmalltalkImage >> processStartUpList: resuming [
	"Send #startUp to each class that needs to run initialization after a snapshot."

	self logStartUpErrorsOf: #FileStream during: [FileStream startUp: resuming].
	self sendStartUp: resuming toClassesNamedIn: StartUpList.
]

{
	#category : #'*SqueakXR-snapshot and quit',
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 14:06'
}
SmalltalkImage >> sendStartUp: resuming toClassesNamedIn: aStartUpList [

	| removals |
	removals := OrderedCollection new.
	aStartUpList do: [:name | | class |
		class := self at: name ifAbsent: [nil].
		class == nil
			ifTrue: [removals add: name]
			ifFalse: [class isInMemory ifTrue: [
				self logStartUpErrorsOf: name during: [class startUp: resuming]]]].
	aStartUpList removeAll: removals.
]
