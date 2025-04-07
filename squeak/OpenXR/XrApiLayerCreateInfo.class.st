Class {
	#name : #XrApiLayerCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrApiLayerCreateInfo class >> fields [

	^ #(
		(structType 'XrLoaderInterfaceStructs')
		(structVersion 'uint32_t')
		(structSize 'size_t')
		(loaderInstance 'void*')
		(settings_file_location 'char[512]')
		(nextInfo 'XrApiLayerNextInfo*')
	)
]
