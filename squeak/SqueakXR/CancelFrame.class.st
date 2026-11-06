"
The image can be saved at any point during frame processing; if certain preconditions are no longer fulfilled after resuming e.g. when resuming within rendering code, this could cause some nasty crashes upon start up.

By signalling the world process with CancelFrame, the current frame processing will immediately be cancelled, so the preconditions are no longer necessary.
"
Class {
	#name : #CancelFrame,
	#superclass : #Notification,
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : 'leo 11/7/2026 00:29'
}
