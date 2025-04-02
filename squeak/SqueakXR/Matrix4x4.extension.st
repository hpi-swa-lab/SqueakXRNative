Extension { #name : #Matrix4x4 }

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> scale [

	"simple implementation, doesn't work for e.g. negative scaling.
	based on https://math.stackexchange.com/a/1463487"
	
	^ Vector3
		x: self column1 length
		y: self column2 length
		z: self column3 length
]
