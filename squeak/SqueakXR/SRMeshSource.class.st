"
A SRMeshSource provides a unified interface to mesh data, abstracting away the underlying implementation.
"
Class {
	#name : #SRMeshSource,
	#superclass : #Object,
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : 'lege 7/6/2026 18:32'
}

{
	#category : #mesh,
	#'squeak_changestamp' : 'lege 7/7/2026 16:36'
}
SRMeshSource >> createInternalMesh [
	
	self subclassResponsibility
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/7/2026 17:25'
}
SRMeshSource >> notifyMeshChanged [

	self changed: #meshChanged.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/6/2026 18:35'
}
SRMeshSource >> onCacheInvalidated [

	"Forces subclasses to make it explicit that nothing needs to be done on cache invalidation." 
	self subclassResponsibility
]
