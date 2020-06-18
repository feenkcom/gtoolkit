Class {
	#name : #GtSubscriptionsShouldNotUseDeliveryConditionWhere,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtSubscriptionsShouldNotUseDeliveryConditionWhere >> description [
	^ 'Announcer weak subscriptions should not use `where:` condition. If it is used with a block, the subscriptions is not going to be garbage-collected.'
]

{ #category : #accessing }
GtSubscriptionsShouldNotUseDeliveryConditionWhere >> issues [
	<return: #GtSearchMethodGroupResult>
	^ '`@rcvr weak when: (`@ann where: `@block) send: `@send to: `@arg' gtASTMatches result
]

{ #category : #accessing }
GtSubscriptionsShouldNotUseDeliveryConditionWhere >> name [
	^ 'Weak subscriptions should not use `where`: delivery condition'
]
