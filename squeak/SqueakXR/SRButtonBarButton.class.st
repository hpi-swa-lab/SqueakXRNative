"
An SRMenuItem outside a menu: same look, hover and trigger handling, but picking it neither closes a cascade nor opens a submenu.
"
Class {
	#name : #SRButtonBarButton,
	#superclass : #SRMenuItem,
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #grabbing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBarButton >> grabTarget [
	^ parent
		ifNil: [super grabTarget]
		ifNotNil: [:bar | bar grabTarget]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBarButton >> menu [
	^ nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBarButton >> naturalWidth [
	^ textField textWidth * textField scale x + 2cm
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBarButton >> width [
	^ size x
]
