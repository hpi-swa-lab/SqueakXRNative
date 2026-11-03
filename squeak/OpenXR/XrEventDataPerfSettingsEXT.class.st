Class {
	#name : #XrEventDataPerfSettingsEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
