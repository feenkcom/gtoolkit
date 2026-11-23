Extension { #name : #WeakSubscriptionBuilder }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakSubscriptionBuilder >> strongSubscriptionMovedFrom: anEphemeronSubscription [
	^(AnnouncementSubscription new)
		announcer: announcer;
		announcementClass: anEphemeronSubscription announcementClass;
		action: anEphemeronSubscription action;
		subscriber: anEphemeronSubscription subscriber;
		yourself
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakSubscriptionBuilder >> subscriptionMovedFrom: anEphemeronSubscription [
	| aMovedSubscription |
	aMovedSubscription := anEphemeronSubscription action isBlock
				ifTrue: [self strongSubscriptionMovedFrom: anEphemeronSubscription]
				ifFalse: [self weakAnnouncementSubscriptionMovedFrom: anEphemeronSubscription].
	anEphemeronSubscription becomeForward: aMovedSubscription.
	^aMovedSubscription
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakSubscriptionBuilder >> weakAnnouncementSubscriptionMovedFrom: anEphemeronSubscription [
	^(WeakAnnouncementSubscription new)
		announcer: announcer;
		action: anEphemeronSubscription action asWeakSubscriptionAction;
		subscriber: anEphemeronSubscription subscriber;
		announcementClass: anEphemeronSubscription announcementClass;
		yourself
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
WeakSubscriptionBuilder >> weakSubscriptionFrom: aSubscription [
	aSubscription action isBlock
		ifTrue: 
			[self error: 'Not currently available due to missing ephemerons support'].
	^(WeakAnnouncementSubscription new)
		announcer: announcer;
		action: aSubscription action asWeakMessageSend;
		subscriber: aSubscription subscriber;
		announcementClass: aSubscription announcementClass;
		yourself
]
