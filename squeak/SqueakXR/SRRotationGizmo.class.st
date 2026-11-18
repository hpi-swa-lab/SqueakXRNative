Class {
	#name : #SRRotationGizmo,
	#superclass : #SRObject,
	#instVars : [
		'activeAxis'
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
	#'squeak_changestamp' : 'phkeese 11/18/2026 14:35'
}
SRRotationGizmo >> isGrabbed [ 

	^ self children anySatisfy: [:c | c isGrabbed ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/18/2026 14:30'
}
SRRotationGizmo >> setRotation: angle [
	
	activeAxis ifNotNil: [:axis | | rot |
		rot := Quaternion axis: axis angle: angle radiansToDegrees.
		self globalRotation: self globalRotation * rot
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/18/2026 14:31'
}
SRRotationGizmo >> startRotatingAround: anAxis [
	
	activeAxis := anAxis.
]
