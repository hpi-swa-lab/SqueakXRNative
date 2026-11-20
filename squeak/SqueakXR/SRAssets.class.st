Class {
	#name : #SRAssets,
	#superclass : #Object,
	#category : #'SqueakXR-Other'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 16:13'
}
SRAssets class >> assetsDirectory [

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
