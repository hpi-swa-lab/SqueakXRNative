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

{
	#category : #'*SqueakXR-row-access',
	#'squeak_changestamp' : 'lege 3/19/2026 14:34'
}
Matrix4x4 >> column4 [
	"Return column 3"
	^ Vector3 x: self a14 y: self a24 z: self a34
]

{
	#category : #'*SqueakXR-row-access',
	#'squeak_changestamp' : 'lege 3/19/2026 14:33'
}
Matrix4x4 >> column4: col [
	"Set column 3"
	self a14: col x.
	self a24: col y.
	self a34: col z
]

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 class >> fromQuaternion: aQuaternion [

	^ self identity setFromQuaternion: aQuaternion
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/19/2026 14:37'
}
Matrix4x4 class >> objectLookAt: target from: position up: worldUp [
	"creates a lookAt matrix for an object (as opposed to a view matrix for a camera)"
	
	| front side up |
	front := (target - position) normalized.
	side := (front cross: worldUp normalized) normalized.
	up := side cross: front.
	^ self identity
		column1:  side;
		column2: up;
		column3: front;
		column4: position;
		yourself
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/18/2026 15:10'
}
Matrix4x4 >> prettyString [

	^ String streamContents: [:stream |
		1 to: 4 do:[:r|
			1 to: 4 do:[:c| 
				(self at: r-1*4+c) printOn: stream showingDecimalPlaces: 2.
				stream nextPut: Character space].
			(r < 4) ifTrue:[stream nextPut: Character cr]]]
]

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> rotationQuaternion [
	"adapted from
	https://d3cw3dd2w32x2b.cloudfront.net/wp-content/uploads/2015/01/matrix-to-quat.pdf "
	
	| q r11 r12 r13 r21 r22 r23 r31 r32 r33 scale t |
	
	scale := self scale.
	r11 := self a11 / scale x.
	r21 := self a12 / scale x.
	r31 := self a13 / scale x.
	r12 := self a21 / scale y.
	r22 := self a22 / scale y.
	r32 := self a23 / scale y.
	r13 := self a31 / scale z.
	r23 := self a32 / scale z.
	r33 := self a33 / scale z.
	
	r33 < 0
		ifTrue: [
			r11 > r22
				ifTrue: [
					t := 1 + r11 - r22 - r33.
					"We create the quaternion like this to avoid normalization in constructor"
					q := {r23 - r32. t. r12 + r21. r31 + r13} as: Quaternion]
				ifFalse: [
					t := 1 - r11 + r22 - r33.
					q := {r31 - r13. r12 + r21. t. r23 + r32} as: Quaternion]]
		ifFalse: [
			r11 < r22 negated
				ifTrue: [
					t := 1 - r11 - r22 + r33.
					q := {r12 - r21. r31 + r13. r23 + r32. t} as: Quaternion]
				ifFalse: [
					t := 1 + r11 + r22 + r33.
					q := {t. r23 - r32. r31 - r13. r12 - r21} as: Quaternion]].
	
	^ (q *= (0.5 / t sqrt)) normalize
]

{
	#category : #'*SqueakXR-row-access',
	#'squeak_changestamp' : 'lege 3/19/2026 14:34'
}
Matrix4x4 >> row4 [
	"Return row 3"
	^ Vector3 x: self a41 y: self a42 z: self a43
]

{
	#category : #'*SqueakXR-row-access',
	#'squeak_changestamp' : 'lege 3/19/2026 14:34'
}
Matrix4x4 >> row4: row [
	"Set row 3"
	self a41: row x.
	self a42: row y.
	self a43: row z
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

{ #category : #'*SqueakXR-helpers' }
Matrix4x4 >> setFromQuaternion: q [
	"Adapted from set_quaternion in https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/math/basis.cpp"
	| s wx wy wz xs xx xy xz ys yy yz zs zz squaredLength |
	squaredLength := q squaredLength.
	squaredLength = 0 ifTrue: [^ self setFromQuaternion: Quaternion identity].
	
	s := 2 / squaredLength.
	xs := q b * s.
	ys := q c * s.
	zs := q d * s.
	wx := q a * xs.
	wy := q a * ys.
	wz := q a * zs.
	xx := q b * xs.
	xy := q b * ys.
	xz := q b * zs.
	yy := q c * ys.
	yz := q c * zs.
	zz := q d * zs.
	
	self a11: 1 - (yy + zz);
		a12: xy - wz;
		a13: xz + wy;
		
		a21: xy + wz;
		a22: 1 - (xx + zz);
		a23: yz - wx;
		
		a31: xz - wy;
		a32: yz + wx;
		a33: 1 - (xx + yy)
]
