Extension { #name : #SubscriptionRegistry }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SubscriptionRegistry >> allStrongSubscriptions [
	^(self protected: [subscriptions asArray])
		reject: [:each | each isWeakSubscription]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SubscriptionRegistry >> allWeakSubscriptions [
	^(self protected: [subscriptions asArray])
		select: [:each | each isWeakSubscription]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SubscriptionRegistry >> hasLeakProneSubscriptionMix [
	| theSubscriptions |
	theSubscriptions := self protected: [subscriptions asArray].
	^(theSubscriptions contains: [:each | each isWeakSubscription])
		and: [theSubscriptions contains: [:each | each isWeakSubscription not]]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SubscriptionRegistry >> weakSubscriptionBuilderFor: anAnnouncer [
	^WeakSubscriptionBuilder on: anAnnouncer
]
