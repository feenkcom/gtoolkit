Extension { #name : #WeakMessageSend }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakMessageSend >> asStrongSubscriptionAction [
	^self asMessageSend
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakMessageSend >> asWeakSubscriptionAction [
	^self
]
