"
I am used to display ${class:Announcer}$ subscriptions per subscribers. 
See ${method:Announcer>>#gtSubscriptionsPerSubscriberFor:}$.
"
Class {
	#name : #GtSubscriptionSubscriber,
	#superclass : #Object,
	#instVars : [
		'subscriber',
		'subscriptions'
	],
	#category : #'GToolkit-Extensions'
}

{ #category : #'api - factory' }
GtSubscriptionSubscriber class >> fromAnnouncer: anAnnouncer [
	| anArray aGroup |
	anArray := anAnnouncer subscriptions subscriptions asArray.
	aGroup := anArray groupedBy: #subscriber.
	^ aGroup associations collect: [ :e | 
		GtSubscriptionSubscriber subscriber: e key subscriptions: e value ]
]

{ #category : #'api - instance creation' }
GtSubscriptionSubscriber class >> subscriber: aSubscriber subscriptions: aCollection [
	^ self new
		subscriber: aSubscriber;
		subscriptions: aCollection
]

{ #category : #'api - accessing' }
GtSubscriptionSubscriber >> announcementClass [
	^ ''
]

{ #category : #printing }
GtSubscriptionSubscriber >> gtDisplayString [
	^ self subscriber
		ifNotNil: #gtDisplayString 
		ifNil: [ super gtDisplayString ]
]

{ #category : #'gt - extensions' }
GtSubscriptionSubscriber >> gtSubscriberFor: aView [
	<gtView>
	self subscriber ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Subscriber';
		priority: 2;
		object: [ self subscriber ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Subscriber' 
			tooltip: 'Inspect subscriber' 
			action: [ :aButton |
				aButton phlow spawnObject: self subscriber ]
]

{ #category : #'gt - extensions' }
GtSubscriptionSubscriber >> gtSubscriptionsFor: aView [
	<gtView>
	self subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 1;
		items: [ self subscriptions ];
		column: 'Subscriber' item: [ :aSubscription | aSubscription subscriber ];
		column: 'Announcement' item: [ :aSubscription | aSubscription announcementClass ];
		column: 'Kind' item: [ :aSubscription | aSubscription class ]
]

{ #category : #'api - testing' }
GtSubscriptionSubscriber >> isEmpty [
	^ self subscriptions isEmpty
]

{ #category : #'api - testing' }
GtSubscriptionSubscriber >> isNotEmpty [
	^ self subscriptions isNotEmpty
]

{ #category : #printing }
GtSubscriptionSubscriber >> printOn: aStream [
	super printOn: aStream.
	self subscriber ifNil: [ ^ self ].
	self subscriptions ifNil: [ ^ self ].
	aStream 
		nextPut: $(;
		print: self subscriber;
		nextPutAll: ', ';
		print: self subscriptions size;
		nextPutAll: (' item' asPluralBasedOn: self subscriptions size);
		nextPut: $)
		
]

{ #category : #'api - accessing' }
GtSubscriptionSubscriber >> subscriber [
	^ subscriber
]

{ #category : #'api - accessing' }
GtSubscriptionSubscriber >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #'api - accessing' }
GtSubscriptionSubscriber >> subscriptions [
	^ subscriptions
]

{ #category : #'api - accessing' }
GtSubscriptionSubscriber >> subscriptions: anObject [
	subscriptions := anObject
]
