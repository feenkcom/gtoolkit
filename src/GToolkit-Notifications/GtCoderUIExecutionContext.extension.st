Extension { #name : #GtCoderUIExecutionContext }

{ #category : #'*GToolkit-Notifications' }
GtCoderUIExecutionContext >> showNotification: aNotification [
	"Show notification in a space (window) in which a code was executed"
	self spaceDo: [ :aSpace | ^ aSpace showNotification: aNotification ].
	
	"The space is closed, display it in another window"
	self showInFocusedSpace: aNotification.
]
