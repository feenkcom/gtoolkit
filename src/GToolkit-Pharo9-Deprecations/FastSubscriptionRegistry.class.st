Class {
	#name : #FastSubscriptionRegistry,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'subscriberMap'
	],
	#category : #'GToolkit-Pharo9-Deprecations-Subscription'
}

{ #category : #accessing }
FastSubscriptionRegistry class >> initialize [
	"Patches for the base image and running SystemAnnouncer"
	| newReg |
	Announcer compile: 'initialize
	super initialize.
	registry := FastSubscriptionRegistry new.' classified: 'initialization'.
	
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
	interestedSubscriptions do: [:sub | [sub deliver: anAnnouncement] valueUninterruptably]
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

{ #category : #accessing }
FastSubscriptionRegistry >> handleSubscriberClass: subClass [
	"Return true if the receiver has a callback subscripbed for the event class"

	^ subscriberMap keys
		anySatisfy: [ :subscriber | subscriber class == subClass or: [ subscriber class includesBehavior: subClass ] ]
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

	^ self protected: [ subscriberMap removeKey: subscriber ifAbsent: [  ] ]
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
	copy do: [ :subscription | aBlock value: subscription ]
]
