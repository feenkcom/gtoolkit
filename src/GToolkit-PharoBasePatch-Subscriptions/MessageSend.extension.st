Extension { #name : #MessageSend }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MessageSend >> asWeakSubscriptionAction [
	^self asWeakMessageSend
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MessageSend >> gtRefersStronglyTo: anObject [
	^receiver == anObject
]
