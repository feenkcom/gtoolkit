Class {
	#name : #GtWeakSubscriptionsWithBlockSubscribers,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtWeakSubscriptionsWithBlockSubscribers >> description [
	^ 'Weak subscriptions should nor use #when:do: and register blocks as receivers. If blocks are used it will have the effect of not garbage-collecting the receiver.'
]

{ #category : #accessing }
GtWeakSubscriptionsWithBlockSubscribers >> issues [
	<return: #GtSearchMethodGroupResult>
	| items |
	items := OrderedCollection new.
	('`@rcvr weak when: `@ann do: `@block' gtASTMatches result) do: [ :each |
		 (each methodClass = ToolRegistry) ifFalse: [items add: each  ]  ].
	^ items
]

{ #category : #accessing }
GtWeakSubscriptionsWithBlockSubscribers >> name [
	^ 'Weak subscriptions should nor use #when:do: and register blocks as receivers.'
]
