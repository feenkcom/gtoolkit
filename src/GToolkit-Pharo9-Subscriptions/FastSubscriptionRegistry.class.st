"
{{gtClass:FastSubscriptionRegistry}} offer a polymorphic API to {{gtClass:SubscriptionRegistry}} and optimises  {{gtMethod:FastSubscriptionRegistry>>subscriptionsOf:do:}} and {{gtMethod:name=FastSubscriptionRegistry>>hasSubscriber:}}.

These optimisations allows users of an announcement to quickly check if an object is registered as subscriber in any of the subscriptions added to the announcer, and access those subscriptions. These kind of checks are used intensily in Bloc to determine if graphical elements should receive events.

To perform these optimizations, the registry holds subscriptions using a {{gtClass:WeakIdentityKeyDictionary}} where the key is the subscriber object. Like this it can get the subscriptions registered for an object with only a dictionary access.

The class side method {{gtMethod:FastSubscriptionRegistry class>>initialize}}  registers this registry as default when the class is initialize.
"
Class {
	#name : #FastSubscriptionRegistry,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'subscriberMap'
	],
	#category : #'GToolkit-Pharo9-Subscriptions-Core'
}

{ #category : #accessing }
FastSubscriptionRegistry class >> initialize [
	"Replaces the subscription registry of the SystemAnnouncer with an instance of the fast subscription registry"
	| newReg |
	
	newReg := FastSubscriptionRegistry new copyFromSlowRegistry: (SystemAnnouncer uniqueInstance instVarNamed: #registry).
	SystemAnnouncer uniqueInstance instVarNamed: #registry put: newReg.
]

{ #category : #'add/remove' }
FastSubscriptionRegistry >> add: subscription [

	^ self protected: [ 
		  (subscriberMap
			   at: subscription subscriber
			   ifAbsentPut: [ IdentitySet new ]) add: subscription ]
]

{ #category : #accessing }
FastSubscriptionRegistry >> copyFromSlowRegistry: aReg [
	aReg protected: [ 
		aReg subscriptions do: [ :each | self add: each].
	]
]

{ #category : #announcing }
FastSubscriptionRegistry >> deliver: anAnnouncement [
	| interestedSubscriptions |
	"using a copy, so subscribers can unsubscribe from announcer "
	subscriberMap isEmpty ifTrue: [ ^ self ].
	self protected: [ interestedSubscriptions := self subscriptionsHandling: anAnnouncement ].
	interestedSubscriptions isEmpty ifTrue: [ ^ self ].
	anAnnouncement prepareForDelivery.
	self deliver: anAnnouncement to: interestedSubscriptions
]

{ #category : #announcing }
FastSubscriptionRegistry >> deliver: anAnnouncement to: subs [
	^ self deliver: anAnnouncement to: subs startingAt: 1
]

{ #category : #announcing }
FastSubscriptionRegistry >> deliver: anAnnouncement to: subs startingAt: startIndex [
	
	startIndex to: subs size do: [ :index| | subscription |
		subscription := subs at: index.
		[ subscription deliver: anAnnouncement ] 
			"Ensure delivery to remaining announcements"
			ifCurtailed: [
				self deliver: anAnnouncement to: subs startingAt: index + 1 ]]
]

{ #category : #'gt - extensions' }
FastSubscriptionRegistry >> gtSubscriptionsFor: aView [
	<gtView>
	self subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 50;
		items: [ self subscriptions asArray ];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Subscriber' text: [ :aSubscription | aSubscription subscriber ];
		column: 'Announcement' text: [ :aSubscription | aSubscription announcementClass ];
		column: 'Kind' text: [ :aSubscription | aSubscription class ]
]

{ #category : #testing }
FastSubscriptionRegistry >> handleEventClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"

	^ subscriberMap anySatisfy: [ :coll | coll anySatisfy: [ :sub | sub announcementClass includesBehavior: eventClass ] ]
]

{ #category : #accessing }
FastSubscriptionRegistry >> handleSubscriberClass: subClass [
	"Return true if the receiver has a callback subscripbed for the event class"

	^ subscriberMap keys
		anySatisfy: [ :subscriber | subscriber class == subClass or: [ subscriber class includesBehavior: subClass ] ]
]

{ #category : #testing }
FastSubscriptionRegistry >> hasSubscriber: anObject [
	^ self protected: [ (subscriberMap at: anObject ifAbsent: [#()]) notEmpty ].
]

{ #category : #initialization }
FastSubscriptionRegistry >> initialize [
	monitor := Semaphore forMutualExclusion.
	self reset
]

{ #category : #accessing }
FastSubscriptionRegistry >> numberOfSubscriptions [
	^ subscriberMap inject: 0 into: [:sum :each | sum + each size]
]

{ #category : #private }
FastSubscriptionRegistry >> protected: aBlock [
	^ monitor critical: [ aBlock value ]
]

{ #category : #'add/remove' }
FastSubscriptionRegistry >> remove: subscription [

	^ self protected: [ 
		  [(subscriberMap at: subscription subscriber ifAbsent: [ ^ self ])
			  remove: subscription
			  ifAbsent: [  ]] onErrorDo: [:ex | ]
		]
]

{ #category : #'add/remove' }
FastSubscriptionRegistry >> removeSubscriber: subscriber [

	^ self protected: [ 
		self 
			forPharo11AndPharo12: [
				| toRemove |
				toRemove := subscriberMap at: subscriber ifAbsent: [ #() ].
				toRemove do: [ :e | e unregister ] ]
			forPharo10: [].
	
		subscriberMap removeKey: subscriber ifAbsent: [  ] ]
]

{ #category : #'add/remove' }
FastSubscriptionRegistry >> replace: subscription with: newOne [

	" Note that it will signal an error if subscription is not there "

	self protected: [ 
		(subscriberMap at: subscription subscriber) remove: subscription.
		(subscriberMap at: subscription subscriber) add: newOne ].
	^ newOne
]

{ #category : #initialization }
FastSubscriptionRegistry >> reset [
	subscriberMap := WeakIdentityKeyDictionary new
]

{ #category : #accessing }
FastSubscriptionRegistry >> subscriptions [
	^ Array streamContents: [ :s | subscriberMap do: [ :each | s nextPutAll: each ] ]
]

{ #category : #accessing }
FastSubscriptionRegistry >> subscriptionsForClass: subscriberClass [
	"Return the list of subscription for a given class"

	^ Array
		streamContents:
			[ :s | 
			subscriberMap
				keysAndValuesDo:
					[ :subscriber :subscriptions | 
					(subscriber class == subscriberClass or: [ subscriber class includesBehavior: subscriberClass ])
						ifTrue: [ s nextPutAll: subscriptions ] ] ]
]

{ #category : #accessing }
FastSubscriptionRegistry >> subscriptionsHandling: anAnnouncement [

	"This will be optimized in the next pass"

	^ Array streamContents: [ :s | 
		  subscriberMap do: [:coll | coll do: [:each | (each handlesAnnouncement: anAnnouncement) ifTrue:[ s nextPut: each] ] ] ]
]

{ #category : #iterating }
FastSubscriptionRegistry >> subscriptionsOf: aSubscriber do: aBlock [
	| copy |
	self protected: [ copy := (subscriberMap at: aSubscriber ifAbsent: [#()]) copy ].
	
	"We work on a copy to avoid issues caused by 
	concurrent changes of the subscriber map."
	copy do: [ :subscription | aBlock value: subscription ]
]
