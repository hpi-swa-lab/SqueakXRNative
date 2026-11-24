Class {
	#name : #SRAssets,
	#superclass : #Object,
	#category : #'SqueakXR-Other'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/24/2026 18:11'
}
SRAssets class >> androidAssetsDirectory [

	^ (FileSystem disk referenceTo: Smalltalk imagePath) / 'assets' / self repositoryName
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/24/2026 18:11'
}
SRAssets class >> assetsDirectory [

	^ self isAndroid
		ifTrue: [self androidAssetsDirectory]
		ifFalse: [self repositoryAssetsDirectory]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/24/2026 18:11'
}
SRAssets class >> isAndroid [

	^ Smalltalk arguments includes: '--android'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/24/2026 18:11'
}
SRAssets class >> repositoryAssetsDirectory [

	^ (({GSBaseWorkingCopy. GSGitWorkingCopy} collect: [:class |
		class named: self repositoryName ifAbsent: [nil]]) detect: #notNil)
			repository workingDir / 'assets'
]

{
	#category : #constants,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 16:13'
}
SRAssets class >> repositoryName [

	^ 'SqueakXRNative'
]
