Extension { #name : #UIManager }

{
	#category : #'*SqueakXR-utilities',
	#'squeak_changestamp' : 'lege 2/16/2026 13:59'
}
UIManager >> askForProvidedAnswerTo: queryString ifSupplied: supplyBlock [

	FileStream stdout nextPutAll: String cr, 'ProvideAnswerNotification received', String cr, queryString;
		flush.
	^ (ProvideAnswerNotification signal: queryString asString)
		ifNotNil: [:value |
			FileStream stdout
				nextPutAll:
					('{1}ProvideAnswerNotification was answered with: {2}'
						format: {String cr. value});
				flush.
			supplyBlock value: value]
		ifNil: [
			FileStream stdout nextPutAll: String cr, 'ProvideAnswerNotification did not receive answer';
				flush.]
]
