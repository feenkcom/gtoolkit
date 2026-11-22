"
I am a weak subscription stored by a {{gtClass:GtMixedSubscriptionRegistry}}. Like a {{gtClass:WeakAnnouncementSubscription}} I reference my subscriber weakly, and {{gtMethod:GtEphemeronSubscriptionBuilder>>#when:send:to:}} and {{gtMethod:AnnouncementSubscription>>#makeWeak}} give me a {{gtClass:WeakMessageSend}} as action, so whoever keeps me does not keep my subscriber alive. Unlike a {{gtClass:WeakAnnouncementSubscription}} I need no entry in the global {{gtClass:FinalizationRegistry}}: the registry holds me behind an ephemeron keyed on my subscriber and removes me when the subscriber is collected.

My action may reference my subscriber strongly, for example a block given to {{gtMethod:GtEphemeronSubscriptionBuilder>>#when:do:for:}} that refers to it. While only the registry holds me, the subscriber can still be collected, because I sit in the value of the subscriber's ephemeron. An object that keeps me does keep the subscriber alive then, as with a {{gtClass:WeakAnnouncementSubscription}}. See {{gtMethod:GtMixedSubscriptionRegistryExamples>>#weakSubscriberCapturedByItsBlockIsCollected}}, {{gtMethod:GtMixedSubscriptionRegistryExamples>>#heldWeakSubscriptionDoesNotKeepItsSubscriberAlive}} and {{gtMethod:GtMixedSubscriptionRegistryExamples>>#heldWeakSubscriptionWithBlockActionKeepsItsSubscriberAlive}}.

{{gtMethod:GtEphemeronAnnouncementSubscription>>#subscriber:}} files me under the new subscriber; like the builder it refuses nil and my own action. {{gtMethod:GtEphemeronAnnouncementSubscription>>#makeStrong}} moves me to the strong subscriptions and, like {{gtMethod:WeakAnnouncementSubscription>>#makeStrong}}, I become the strong subscription, so references to me follow; it fails when my subscriber is gone. Moved to another kind of registry with {{gtMethod:Announcer>>#useSubscriptionRegistry:}}, I become a {{gtClass:WeakAnnouncementSubscription}}, or a strong subscription if my action is a block, and references to me follow as well.

{{gtMethod:GtEphemeronAnnouncementSubscription>>#gtLifetimeFor:}} shows whether my subscriber is still alive, whether the registry still holds me, and whether my action refers to my subscriber, so that an object holding me keeps the subscriber alive.
"
Class {
	#name : #GtEphemeronAnnouncementSubscription,
	#superclass : #AbstractAnnouncementSubscription,
	#instVars : [
		'subscriberReference'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #asserting }
GtEphemeronAnnouncementSubscription class >> assertSubscriber: aSubscriber canBeWeakFor: aValuable [
	aSubscriber
		ifNil: [ self
				error: 'A weak subscription needs a subscriber that can be garbage collected' ].
	aValuable == aSubscriber
		ifTrue: [ self
				error: 'A valuable that is its own subscriber cannot be subscribed weakly' ]
]

{ #category : #registering }
GtEphemeronAnnouncementSubscription >> addToMixedSubscriptionRegistry: aRegistry [
	^aRegistry addWeakSubscription: self
]

{ #category : #private }
GtEphemeronAnnouncementSubscription >> basicSubscriber: aSubscriber [
	subscriberReference at: 1 put: aSubscriber
]

{ #category : #'gt - extensions' }
GtEphemeronAnnouncementSubscription >> gtLifetimeFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Lifetime';
		priority: 5;
		items: [self gtLifetimeRows];
		actionUpdateButtonTooltip: 'Update';
		column: 'Property'
			text: [:each | each first]
			width: 200;
		column: 'Value' text: [:each | each second];
		send: [:each | each last]
]

{ #category : #'gt - extensions' }
GtEphemeronAnnouncementSubscription >> gtLifetimeRows [
	| aSubscriber aRegistry |
	aSubscriber := self subscriber.
	aRegistry := announcer subscriptions.
	^(OrderedCollection new)
		add: (Array
					with: 'Subscriber'
					with: (aSubscriber ifNil: ['collected'] ifNotNil: [aSubscriber printString])
					with: aSubscriber);
		add: (Array
					with: 'Announcer'
					with: announcer printString
					with: announcer);
		add: (Array
					with: 'Held by the registry'
					with: ((aRegistry subscriptions contains: [:each | each == self])
							ifTrue: ['yes, in the group of the subscriber']
							ifFalse: ['no: unsubscribed, or the subscriber was collected'])
					with: aRegistry);
		add: (Array
					with: 'Action'
					with: action printString
					with: action);
		add: (Array
					with: 'Action refers to the subscriber'
					with: ((aSubscriber notNil and: [action gtRefersStronglyTo: aSubscriber])
							ifTrue: 
								['yes: an object that holds this subscription keeps the subscriber alive']
							ifFalse: ['no: holding this subscription does not keep the subscriber alive'])
					with: action);
		yourself
]

{ #category : #'gt - extensions' }
GtEphemeronAnnouncementSubscription >> gtSourceCodeFor: aView [
	<gtView>
	^(aView forward)
		title: 'Called method';
		object: [self action];
		view: #gtMethodFor:
]

{ #category : #initialization }
GtEphemeronAnnouncementSubscription >> initialize [
	super initialize.
	subscriberReference := WeakArray new: 1
]

{ #category : #testing }
GtEphemeronAnnouncementSubscription >> isWeakSubscription [
	^true
]

{ #category : #converting }
GtEphemeronAnnouncementSubscription >> makeStrong [
	| aSubscriber |
	aSubscriber := self subscriber.
	aSubscriber
		ifNil: [^self error: 'Subscriber is nil, cannot make strong subscription'].
	^announcer subscriptions makeStrong: self for: aSubscriber
]

{ #category : #converting }
GtEphemeronAnnouncementSubscription >> makeWeak [
	^self
]

{ #category : #registering }
GtEphemeronAnnouncementSubscription >> removeFromMixedSubscriptionRegistry: aRegistry [
	^aRegistry removeWeakSubscription: self
]

{ #category : #accessing }
GtEphemeronAnnouncementSubscription >> subscriber [
	^subscriberReference at: 1
]

{ #category : #accessing }
GtEphemeronAnnouncementSubscription >> subscriber: aSubscriber [
	announcer
		ifNil: [self basicSubscriber: aSubscriber]
		ifNotNil: 
			[self class assertSubscriber: aSubscriber canBeWeakFor: action.
			announcer subscriptions changeSubscriberOf: self to: aSubscriber]
]

{ #category : #converting }
GtEphemeronAnnouncementSubscription >> subscriptionToMoveWith: aWeakSubscriptionBuilder [
	^aWeakSubscriptionBuilder subscriptionMovedFrom: self
]

{ #category : #finalization }
GtEphemeronAnnouncementSubscription >> unregister [
	
]
