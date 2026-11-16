Class {
	#name : #SRRotationGizmo,
	#superclass : #SRObject,
	#instVars : [
		'target',
		'initialRotation',
		'activeAxis',
		'activeAngle'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:31'
}
SRRotationGizmo >> initialize [ 

	super initialize.
	
	#((right red) (up green) (backward blue)) do: [:pair | | axis color |
		axis := Vector3 perform: pair first.
		color := Color perform: pair second.
		self addChild: (SRRotationHandle new
			name: axis;
			color: color;
			axis: axis;
			grabAction: [:handle | self startRotatingAround: handle axis];
			rotateAction: [:handle :angle | self setRotation: angle]
		)
	]
		 
		
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:26'
}
SRRotationGizmo >> setRotation: angle [
	
	"Todo: apply rotation to our target."
	Transcript showln: 'Angle = ', angle.
	activeAngle := angle.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:27'
}
SRRotationGizmo >> startRotatingAround: anAxis [
	
	"Todo: prepare roating our target object."
	Transcript showln: 'Starting rotation around ', anAxis.
	initialRotation := self rotation.
	activeAxis := anAxis.
	activeAngle := 0.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:26'
}
SRRotationGizmo >> step: deltaTime [

	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:14'
}
SRRotationGizmo >> target [
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:14'
}
SRRotationGizmo >> target: anObject [
	target := anObject
]
