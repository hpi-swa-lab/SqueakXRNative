Extension { #name : #Matrix4x4 }

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> asRaylibObject [

	^ self asRlMatrix
]

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> asRlMatrix [
	"Probably not very efficient. Better options might be:
	1.Reinterpret the byte representation of the Matrix4x4 via fromHandle:.
		Not sure if possible.
	2. Do externally via FFI.
	3. Subclass Matrix4x4 and have it maintain an internal RlMatrix."
	^ RlMatrix new
		m0: self a11; m4: self a12; m8:   self a13; m12: self a14;
		m1: self a21; m5: self a22; m9:   self a23; m13: self a24;
		m2: self a31; m6: self a32; m10: self a33; m14: self a34;
		m3: self a41; m7: self a42; m11: self a43; m15: self a44
		
]

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> scale [

	"simple implementation, doesn't work for e.g. negative scaling.
	based on https://math.stackexchange.com/a/1463487"
	
	^ Vector3
		x: self column1 length
		y: self column2 length
		z: self column3 length
]
