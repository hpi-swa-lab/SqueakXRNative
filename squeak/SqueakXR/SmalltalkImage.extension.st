Extension { #name : #SmalltalkImage }

{
	#category : #'*SqueakXR-snapshot and quit',
	#'squeak_changestamp' : 'lege 2/16/2026 13:41'
}
SmalltalkImage >> processStartUpList: resuming [
	"Send #startUp to each class that needs to run initialization after a snapshot."

	FileStream startUp: resuming.
	self send: #startUp: toClassesNamedIn: StartUpList with: resuming.

]
