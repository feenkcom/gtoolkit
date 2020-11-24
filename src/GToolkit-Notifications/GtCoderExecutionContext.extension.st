Extension { #name : #GtCoderExecutionContext }

{ #category : #'*GToolkit-Notifications' }
GtCoderExecutionContext >> removeInAllSpaces: aNotification [
	BlSpace allSubInstancesDo: [ :aSpace |
		aSpace removeNotification: aNotification ].
]

{ #category : #'*GToolkit-Notifications' }
GtCoderExecutionContext >> removeNotification: aNotification [
	self removeInAllSpaces: aNotification
]

{ #category : #'*GToolkit-Notifications' }
GtCoderExecutionContext >> showInFocusedSpace: aNotification [
	"Such a space is closed, display it in a focused space".
	BlSpace allSubInstancesDo: [ :aSpace | 
		aSpace isFocused ifTrue: [ ^ aSpace showNotification: aNotification ] ].

	"There is no a focused space, display it in any space"
	BlSpace allSubInstancesDo: [ :aSpace | 
		aSpace isOpen ifTrue: [ ^ aSpace showNotification: aNotification ] ].

]

{ #category : #'*GToolkit-Notifications' }
GtCoderExecutionContext >> showNotification: aNotification [
	self subclassResponsibility
]
