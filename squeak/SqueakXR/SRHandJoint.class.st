Class {
	#name : #SRHandJoint,
	#superclass : #SRObject,
	#instVars : [
		'jointIndex',
		'jointCube',
		'bones'
	],
	#category : #'SqueakXR-HandTracking'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 13:16'
}
SRHandJoint class >> jointNames [

	^ #('palm' 'wrist' 'thumb metacarpal' 'thumb proximal' 'thumb distal' 'thumb tip' 'index metacarpal' 'index proximal' 'index intermediate' 'index distal' 'index tip' 'middle metacarpal' 'middle proximal' 'middle intermediate' 'middle distal' 'middle tip' 'ring metacarpal' 'ring proximal' 'ring intermediate' 'ring distal' 'ring tip' 'little metacarpal' 'little proximal' 'little intermediate' 'little distal' 'little tip')
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 14:02'
}
SRHandJoint class >> nameForIndex: jointIndex [

	^ self jointNames at: jointIndex value + 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 12:35'
}
SRHandJoint class >> withJointIndex: jointIndex [

	^ self new jointIndex: jointIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 10/23/2026 13:38'
}
SRHandJoint >> bones [

	^ bones ifNil: [bones := OrderedCollection new]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 13:36'
}
SRHandJoint >> connectTo: aJoint [

	| bone |
	bone := SRCube new color: Color gray veryMuchDarker.
	self addChild: bone.
	self bones add: aJoint -> bone.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 13:40'
}
SRHandJoint >> connectToJointFrom: jointCollection [

	| indices |
	indices := (self jointIndex value caseOf: {
		[XrHandJointEXT XR_HAND_JOINT_THUMB_TIP_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_THUMB_DISTAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_THUMB_DISTAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_THUMB_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_THUMB_PROXIMAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_THUMB_METACARPAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_THUMB_METACARPAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_WRIST_EXT}].
		
		[XrHandJointEXT XR_HAND_JOINT_INDEX_TIP_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_INDEX_DISTAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_INDEX_DISTAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_INDEX_INTERMEDIATE_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_INDEX_INTERMEDIATE_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_INDEX_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_INDEX_PROXIMAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_INDEX_METACARPAL_EXT. XrHandJointEXT XR_HAND_JOINT_THUMB_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_INDEX_METACARPAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_WRIST_EXT}].
		
		[XrHandJointEXT XR_HAND_JOINT_MIDDLE_TIP_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_MIDDLE_DISTAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_MIDDLE_DISTAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_MIDDLE_INTERMEDIATE_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_MIDDLE_INTERMEDIATE_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_MIDDLE_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_MIDDLE_PROXIMAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_MIDDLE_METACARPAL_EXT. XrHandJointEXT XR_HAND_JOINT_INDEX_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_MIDDLE_METACARPAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_WRIST_EXT}].
		
		[XrHandJointEXT XR_HAND_JOINT_RING_TIP_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_RING_DISTAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_RING_DISTAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_RING_INTERMEDIATE_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_RING_INTERMEDIATE_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_RING_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_RING_PROXIMAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_RING_METACARPAL_EXT. XrHandJointEXT XR_HAND_JOINT_MIDDLE_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_RING_METACARPAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_WRIST_EXT}].
		
		[XrHandJointEXT XR_HAND_JOINT_LITTLE_TIP_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_LITTLE_DISTAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_LITTLE_DISTAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_LITTLE_INTERMEDIATE_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_LITTLE_INTERMEDIATE_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_LITTLE_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_LITTLE_PROXIMAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_LITTLE_METACARPAL_EXT. XrHandJointEXT XR_HAND_JOINT_RING_PROXIMAL_EXT}].
		[XrHandJointEXT XR_HAND_JOINT_LITTLE_METACARPAL_EXT value] -> [{XrHandJointEXT XR_HAND_JOINT_WRIST_EXT}].
	} otherwise: [#()]).
	
	indices do: [:index | self connectTo: (jointCollection at: index value + 1)].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 13:35'
}
SRHandJoint >> connectedJoints [

	^ self bones collect: [:bone | bone key]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 13:37'
}
SRHandJoint >> initialize [

	super initialize.

	self addChild: (jointCube := SRCube new scale: 1cm asVector3; color: Color gray).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:47'
}
SRHandJoint >> jointIndex [

	^ jointIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 13:59'
}
SRHandJoint >> jointIndex: newJointIndex [

	jointIndex := newJointIndex isInteger
		ifTrue: [XrHandJointEXT on: newJointIndex]
		ifFalse: [newJointIndex].
	
	jointIndex ifNotNil: [self name: (self class nameForIndex: jointIndex)].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 13:37'
}
SRHandJoint >> updateJoint: jointLocations [

	| pose |
	self assert: self jointIndex notNil.
	
	pose := (jointLocations at: self jointIndex value + 1) pose.
	self position: (Vector3 fromXrVector3f: pose position);
		rotation: (Quaternion fromXrQuaternionf: pose orientation).
	
	self bones do: [:bone | | toConnected |
		"setting the bone position like this assumes that the connected joint was already updated;
		works in this case because of the hand joint enum ordering"
		toConnected := (self globalTransform globalPointToLocal: bone key globalTranslation).
		bone value transform:
			(Matrix4x4 objectLookAt: toConnected
				from: toConnected / 2
				up: Vector3 up)
				* (Matrix4x4 withScale: 0.5cm @ 0.5cm @ toConnected length)]
]
