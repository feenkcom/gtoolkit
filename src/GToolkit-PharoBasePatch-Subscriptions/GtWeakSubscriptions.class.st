"
I am the weak part of a {{gtClass:GtMixedSubscriptionRegistry}} that has weak subscribers: an {{gtClass:IdentityDictionary}} of ephemerons keyed on the subscribers, whose values are the sets of their subscriptions.
I am never empty: when my last subscriber is removed I answer the shared {{gtClass:GtNoWeakSubscriptions}}. {{gtMethod:GtWeakSubscriptions>>#withoutEphemeron:}} removes an entry only while it is still that ephemeron, so a late mourn keeps a newer subscription of the same subscriber.
"
Class {
	#name : #GtWeakSubscriptions,
	#superclass : #GtAbstractWeakSubscriptions,
	#instVars : [
		'ephemerons'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #accessing }
GtWeakSubscriptions >> ephemeronOf: aSubscriber [
	^ephemerons associationAt: aSubscriber ifAbsent: [nil]
]

{ #category : #'gt - extensions' }
GtWeakSubscriptions >> gtOverviewDescription [
	^self numberOfSubscribers printString , (self numberOfSubscribers = 1
				ifTrue: [' ephemeron']
				ifFalse: [' ephemerons'])
		, ', one per weak subscriber'
]

{ #category : #initialization }
GtWeakSubscriptions >> initialize [
	super initialize.
	ephemerons := IdentityDictionary new
]

{ #category : #testing }
GtWeakSubscriptions >> isEmpty [
	^ephemerons isEmpty
]

{ #category : #accessing }
GtWeakSubscriptions >> numberOfSubscribers [
	^ephemerons size
]

{ #category : #accessing }
GtWeakSubscriptions >> numberOfSubscriptions [
	^ephemerons inject: 0 into: [:aSum :each | aSum + each size]
]

{ #category : #private }
GtWeakSubscriptions >> releasedWhenEmpty [
	^self isEmpty
		ifTrue: [GtNoWeakSubscriptions uniqueInstance]
		ifFalse: [self]
]

{ #category : #accessing }
GtWeakSubscriptions >> subscribersWithSubscriptions [
	^ Array
		streamContents: [ :aStream | 
			ephemerons
				keysAndValuesDo: [ :aSubscriber :theSubscriptions | aStream nextPut: aSubscriber -> theSubscriptions asArray ] ]
]

{ #category : #enumerating }
GtWeakSubscriptions >> subscriptionsDo: aBlock [
	ephemerons do: [:theSubscriptions | theSubscriptions do: aBlock]
]

{ #category : #accessing }
GtWeakSubscriptions >> subscriptionsOf: aSubscriber ifAbsent: aBlock [
	^ephemerons at: aSubscriber ifAbsent: aBlock
]

{ #category : #changing }
GtWeakSubscriptions >> withEphemeron: anEphemeron [
	ephemerons removeKey: anEphemeron key ifAbsent: [].
	ephemerons add: anEphemeron.
	^self
]

{ #category : #changing }
GtWeakSubscriptions >> withoutEphemeron: anEphemeron [
	(ephemerons associationAt: anEphemeron key ifAbsent: [nil]) == anEphemeron
		ifTrue: [ephemerons removeKey: anEphemeron key].
	^self releasedWhenEmpty
]

{ #category : #changing }
GtWeakSubscriptions >> withoutSubscriber: aSubscriber [
	ephemerons removeKey: aSubscriber ifAbsent: [].
	^self releasedWhenEmpty
]
