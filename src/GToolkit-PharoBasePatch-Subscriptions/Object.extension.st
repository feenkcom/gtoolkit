Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> addToMixedSubscriptionRegistry: aRegistry [
	^aRegistry addStrongSubscription: self
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> asStrongSubscriptionAction [
	^self
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> asWeakSubscriptionAction [
	^self
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> gtRefersStronglyTo: anObject [
	^false
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> isWeakSubscription [
	^false
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> removeFromMixedSubscriptionRegistry: aRegistry [
	^aRegistry removeStrongSubscription: self
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Object >> subscriptionToMoveWith: aWeakSubscriptionBuilder [
	^self
]
