Extension { #name : #ExternalType }

{ #category : #'*OpenXR-core' }
ExternalType class >> removeUnknownTypes [

	StructTypes keysAndValuesRemove: [:key :value |
		value notNil and: [
			value isUnknownType
				or: [ '<unknown struct type>'  = (String streamContents: [:stream | value printOn: stream])]]]
]
