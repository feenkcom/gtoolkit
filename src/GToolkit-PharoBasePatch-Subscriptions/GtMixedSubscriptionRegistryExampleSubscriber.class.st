"
I am a subscriber used by {{gtClass:GtMixedSubscriptionRegistryExamples}}. I record the announcements I receive and can hold another object, to model ownership between subscribers, models and announcers.
"
Class {
	#name : #GtMixedSubscriptionRegistryExampleSubscriber,
	#superclass : #Object,
	#instVars : [
		'announcements',
		'heldObject'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Examples'
}

{ #category : #accessing }
GtMixedSubscriptionRegistryExampleSubscriber >> announcements [
	^announcements
]

{ #category : #accessing }
GtMixedSubscriptionRegistryExampleSubscriber >> heldObject [
	^heldObject
]

{ #category : #accessing }
GtMixedSubscriptionRegistryExampleSubscriber >> heldObject: anObject [
	heldObject := anObject
]

{ #category : #initialization }
GtMixedSubscriptionRegistryExampleSubscriber >> initialize [
	super initialize.
	announcements := OrderedCollection new
]

{ #category : #'announcement handling' }
GtMixedSubscriptionRegistryExampleSubscriber >> onAnnouncement: anAnnouncement [
	announcements add: anAnnouncement
]

{ #category : #subscribing }
GtMixedSubscriptionRegistryExampleSubscriber >> subscribeWithBlockTo: anAnnouncer [
	^anAnnouncer weak
		when: JobStart
		do: [:anAnnouncement | self onAnnouncement: anAnnouncement]
		for: self
]
