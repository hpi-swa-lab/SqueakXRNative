Class {
	#name : #SRAssets,
	#superclass : #Object,
	#category : #'SqueakXR-Other'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/3/2026 14:08'
}
SRAssets class >> assetsDirectory [

	^ (({GSBaseWorkingCopy. GSGitWorkingCopy} collect: [:class |
		class named: 'SqueakXRNative' ifAbsent: [nil]]) detect: #notNil)
			repository workingDir / 'assets'
]
