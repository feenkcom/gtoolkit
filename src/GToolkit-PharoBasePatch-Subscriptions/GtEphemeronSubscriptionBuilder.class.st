"
I am answered by {{gtMethod:Announcer>>#weak}} when the announcer uses a {{gtClass:GtMixedSubscriptionRegistry}}. I create {{gtClass:GtEphemeronAnnouncementSubscription}}s with {{gtMethod:GtEphemeronSubscriptionBuilder>>#when:send:to:}} and {{gtMethod:GtEphemeronSubscriptionBuilder>>#when:do:for:}}; the subscriber is always given explicitly. I refuse two kinds of subscriber with an error ({{gtMethod:GtEphemeronAnnouncementSubscription class>>#assertSubscriber:canBeWeakFor:}}): nil, which can never be collected, so the subscription would never go away, and a valuable that is its own subscriber, which nothing else references, so the subscription would vanish at the next garbage collection.
I hand each new subscription to the weak builder of the registry my announcer uses at that moment, so a builder kept while the announcer switched to a plain registry still subscribes a {{gtClass:WeakAnnouncementSubscription}} there.
"
Class {
	#name : #GtEphemeronSubscriptionBuilder,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #'instance creation' }
GtEphemeronSubscriptionBuilder class >> on: anAnnouncer [
	^self new announcer: anAnnouncer
]

{ #category : #initialization }
GtEphemeronSubscriptionBuilder >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #converting }
GtEphemeronSubscriptionBuilder >> subscriptionMovedFrom: anEphemeronSubscription [
	^anEphemeronSubscription
]

{ #category : #private }
GtEphemeronSubscriptionBuilder >> subscriptionTo: anAnnouncementClass do: aValuable for: aSubscriber [
	GtEphemeronAnnouncementSubscription assertSubscriber: aSubscriber
		canBeWeakFor: aValuable.
	^(GtEphemeronAnnouncementSubscription new)
		announcer: announcer;
		announcementClass: anAnnouncementClass;
		action: aValuable;
		basicSubscriber: aSubscriber;
		yourself
]

{ #category : #'wrapped protocol' }
GtEphemeronSubscriptionBuilder >> weak [
	^self
]

{ #category : #converting }
GtEphemeronSubscriptionBuilder >> weakSubscriptionFrom: aSubscription [
	^self
		subscriptionTo: aSubscription announcementClass
		do: aSubscription action asWeakSubscriptionAction
		for: aSubscription subscriber
]

{ #category : #'wrapped protocol' }
GtEphemeronSubscriptionBuilder >> when: anAnnouncementClass do: aValuable for: aSubscriber [
	| aSubscription aBuilderOfTheCurrentRegistry |
	aSubscription := self
				subscriptionTo: anAnnouncementClass
				do: aValuable
				for: aSubscriber.
	aBuilderOfTheCurrentRegistry := announcer subscriptions
				weakSubscriptionBuilderFor: announcer.
	^announcer basicSubscribe: (aSubscription
				subscriptionToMoveWith: aBuilderOfTheCurrentRegistry)
]

{ #category : #'wrapped protocol' }
GtEphemeronSubscriptionBuilder >> when: anAnnouncementClass send: aSelector to: anObject [
	^self
		when: anAnnouncementClass
		do: (WeakMessageSend receiver: anObject selector: aSelector)
		for: anObject
]
