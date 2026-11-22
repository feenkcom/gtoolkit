"
I am the weak part of a {{gtClass:GtMixedSubscriptionRegistry}} that has no weak subscribers. I have no state, so all registries share {{gtMethod:GtNoWeakSubscriptions class>>#uniqueInstance}} and nothing can change me. Adding an ephemeron answers a new {{gtClass:GtWeakSubscriptions}}.
"
Class {
	#name : #GtNoWeakSubscriptions,
	#superclass : #GtAbstractWeakSubscriptions,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #accessing }
GtNoWeakSubscriptions class >> uniqueInstance [
	^UniqueInstance ifNil: [UniqueInstance := self new]
]

{ #category : #accessing }
GtNoWeakSubscriptions >> ephemeronOf: aSubscriber [
	^nil
]

{ #category : #'gt - extensions' }
GtNoWeakSubscriptions >> gtOverviewDescription [
	^'the shared empty part, used while there is no weak subscriber'
]

{ #category : #testing }
GtNoWeakSubscriptions >> isEmpty [
	^true
]

{ #category : #accessing }
GtNoWeakSubscriptions >> numberOfSubscribers [
	^0
]

{ #category : #accessing }
GtNoWeakSubscriptions >> numberOfSubscriptions [
	^0
]

{ #category : #accessing }
GtNoWeakSubscriptions >> subscribersWithSubscriptions [
	^#()
]

{ #category : #enumerating }
GtNoWeakSubscriptions >> subscriptionsDo: aBlock [
	
]

{ #category : #accessing }
GtNoWeakSubscriptions >> subscriptionsOf: aSubscriber ifAbsent: aBlock [
	^aBlock value
]

{ #category : #changing }
GtNoWeakSubscriptions >> withEphemeron: anEphemeron [
	^GtWeakSubscriptions new withEphemeron: anEphemeron
]

{ #category : #changing }
GtNoWeakSubscriptions >> withoutEphemeron: anEphemeron [
	^self
]

{ #category : #changing }
GtNoWeakSubscriptions >> withoutSubscriber: aSubscriber [
	^self
]
