Class {
	#name : #XrEventDataPerfSettingsEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataPerfSettingsEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(domain 'XrPerfSettingsDomainEXT')
		(subDomain 'XrPerfSettingsSubDomainEXT')
		(fromLevel 'XrPerfSettingsNotificationLevelEXT')
		(toLevel 'XrPerfSettingsNotificationLevelEXT')
	)
]
