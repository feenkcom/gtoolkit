"
I am the weak part of a {{gtClass:GtMixedSubscriptionRegistry}}: its weak subscriptions, grouped by subscriber, each group held through an ephemeron (a {{gtClass:WeakKeyAssociation}}) keyed on the subscriber.
My changes, {{gtMethod:GtAbstractWeakSubscriptions>>#withEphemeron:}}, {{gtMethod:GtAbstractWeakSubscriptions>>#withoutSubscriber:}} and {{gtMethod:GtAbstractWeakSubscriptions>>#withoutEphemeron:}}, change me in place and answer the part the registry keeps from then on: a new part when the first ephemeron is added to the empty one, the shared empty part when the last one is removed, otherwise myself. This lets all registries without weak subscribers share one stateless empty part. The registry changes me only under its lock.
"
Class {
	#name : #GtAbstractWeakSubscriptions,
	#superclass : #Object,
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #accessing }
GtAbstractWeakSubscriptions >> ephemeronOf: aSubscriber [
	^self subclassResponsibility
]

{ #category : #'gt - extensions' }
GtAbstractWeakSubscriptions >> gtOverviewDescription [
	^self subclassResponsibility
]

{ #category : #testing }
GtAbstractWeakSubscriptions >> isEmpty [
	^self subclassResponsibility
]

{ #category : #accessing }
GtAbstractWeakSubscriptions >> numberOfSubscribers [
	^self subclassResponsibility
]

{ #category : #accessing }
GtAbstractWeakSubscriptions >> numberOfSubscriptions [
	^self subclassResponsibility
]

{ #category : #accessing }
GtAbstractWeakSubscriptions >> subscribersWithSubscriptions [
	^self subclassResponsibility
]

{ #category : #enumerating }
GtAbstractWeakSubscriptions >> subscriptionsDo: aBlock [
	^self subclassResponsibility
]

{ #category : #accessing }
GtAbstractWeakSubscriptions >> subscriptionsOf: aSubscriber ifAbsent: aBlock [
	^self subclassResponsibility
]

{ #category : #changing }
GtAbstractWeakSubscriptions >> withEphemeron: anEphemeron [
	^self subclassResponsibility
]

{ #category : #changing }
GtAbstractWeakSubscriptions >> withoutEphemeron: anEphemeron [
	^self subclassResponsibility
]

{ #category : #changing }
GtAbstractWeakSubscriptions >> withoutSubscriber: aSubscriber [
	^self subclassResponsibility
]
