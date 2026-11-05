Class {
	#name : #SRRotationHandle,
	#superclass : #SRObject,
	#category : #'SqueakXR-Halo'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:44'
}
SRRotationHandle >> axis [
	
	^ self forward
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:32'
}
SRRotationHandle >> collisionGeometry [ 

	^ SRCollisionTorus new
		axis: self axis;
		major: self globalScale x;
		minor: self globalScale x / 10;
		center: self globalTranslation;
		object: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:17'
}
SRRotationHandle >> initialize [ 

	super initialize.
	
	axis := Vector3 right.
	radius := 1.
	thickness := 10cm.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:25'
}
SRRotationHandle >> step: deltaTime [ 

	self gizmoPainter gizmoWireTorus: self collisionGeometry color: Color black
]
