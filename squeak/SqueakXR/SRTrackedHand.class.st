Class {
	#name : #SRTrackedHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex',
		'joints',
		'positionJoint',
		'aimBox',
		'previousGesture'
	],
	#category : #'SqueakXR-HandTracking'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:43'
}
SRTrackedHand class >> jointCount [

	^ 26
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 18:18'
}
SRTrackedHand class >> left [

	^ self new handIndex: self leftIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:39'
}
SRTrackedHand class >> leftIndex [

	^ 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 18:18'
}
SRTrackedHand class >> right [

	^ self new handIndex: self rightIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:39'
}
SRTrackedHand class >> rightIndex [

	^ 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 14:54'
}
SRTrackedHand >> deriveGesture [

	| jointsTopToBottom middleTip otherTips middleIntermediate |
	jointsTopToBottom := self joints sorted: [:jointA :jointB | jointA position y > jointB position y].
	
	middleTip := jointsTopToBottom indexOf: self middleTip.
	middleIntermediate := jointsTopToBottom indexOf: self middleIntermediate.
	otherTips := {self thumbTip. self indexTip. self ringTip. self littleTip}
		collect: [:joint | jointsTopToBottom indexOf: joint].
	
	(middleTip = 1 and: [otherTips allSatisfy: [:tip | middleIntermediate < tip]]) ifTrue: [^ #delete].

	(middleTip < middleIntermediate and: [
		((self middleTip position - self wrist position) angleTo: Vector3 up) < (Float pi / 4)]) ifTrue: [
		^ #backAim].
	
	
	^ nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:37'
}
SRTrackedHand >> handIndex [

	^ handIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:38'
}
SRTrackedHand >> handIndex: anInteger [

	handIndex := anInteger
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> indexDistal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_INDEX_DISTAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> indexIntermediate [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_INDEX_INTERMEDIATE_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> indexMetacarpal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_INDEX_METACARPAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> indexProximal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_INDEX_PROXIMAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> indexTip [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_INDEX_TIP_EXT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 14:26'
}
SRTrackedHand >> initialize [

	super initialize.
	
	self joints: (Array new: self class jointCount).
	1 to: self class jointCount do: [:idx |
		self joints at: idx put: (SRHandJoint withJointIndex: idx - 1)].
	
	self positionJoint: (self joints at: XrHandJointEXT XR_HAND_JOINT_PALM_EXT + 1).
	
	self joints do: [:joint |
		joint connectToJointFrom: self joints].
	
	self addChildren: self joints.
	
	self palm addChild: (aimBox := SRCube new
		color: Color red;
		scale: 3mm @ 10m @ 3mm;
		position: 0 @ 5m @ 0;
		visible: false).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:38'
}
SRTrackedHand >> isLeft [

	^ self handIndex = self class leftIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:38'
}
SRTrackedHand >> isRight [

	^ self handIndex = self class rightIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 13:46'
}
SRTrackedHand >> jointForNamedIndex: index [

	^ self joints at: index value + 1 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:42'
}
SRTrackedHand >> joints [

	^ joints
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:43'
}
SRTrackedHand >> joints: anSequenceableCollection [

	joints := anSequenceableCollection
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> littleDistal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_LITTLE_DISTAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> littleIntermediate [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_LITTLE_INTERMEDIATE_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> littleMetacarpal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_LITTLE_METACARPAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> littleProximal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_LITTLE_PROXIMAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> littleTip [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_LITTLE_TIP_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> middleDistal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_MIDDLE_DISTAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> middleIntermediate [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_MIDDLE_INTERMEDIATE_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> middleMetacarpal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_MIDDLE_METACARPAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> middleProximal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_MIDDLE_PROXIMAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> middleTip [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_MIDDLE_TIP_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> palm [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_PALM_EXT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:51'
}
SRTrackedHand >> positionJoint [

	^ positionJoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 17:50'
}
SRTrackedHand >> positionJoint: joint [

	positionJoint := joint
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> ringDistal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_RING_DISTAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> ringIntermediate [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_RING_INTERMEDIATE_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> ringMetacarpal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_RING_METACARPAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> ringProximal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_RING_PROXIMAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> ringTip [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_RING_TIP_EXT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 14:54'
}
SRTrackedHand >> step: delta [

	| gesture |
	gesture := self deriveGesture.
	
	aimBox visible: (gesture = #delete or: [gesture = #backAim]).
	(previousGesture ~= #delete and: [gesture = #delete]) ifTrue: [
		self palm castRayUp ifNotNil: [:result | result object remove]].
	
	previousGesture := gesture.
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> thumbDistal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_THUMB_DISTAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> thumbMetacarpal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_THUMB_METACARPAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> thumbProximal [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_THUMB_PROXIMAL_EXT
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> thumbTip [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_THUMB_TIP_EXT
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:07'
}
SRTrackedHand >> update: aSymbol with: anObject [

	aSymbol = #handJointsUpdated ifTrue: [
		self updateJoints: (self isLeft
			ifTrue: [anObject leftJointLocations]
			ifFalse: [anObject rightJointLocations])].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/22/2026 18:22'
}
SRTrackedHand >> updateJoints: jointLocations [

	self joints do: [:joint | joint updateJoint: jointLocations]
]

{
	#category : #'accessing - joints',
	#'squeak_changestamp' : 'MCPServer (leo) 10/23/2026 14:05'
}
SRTrackedHand >> wrist [

	^ self jointForNamedIndex: XrHandJointEXT XR_HAND_JOINT_WRIST_EXT
]
