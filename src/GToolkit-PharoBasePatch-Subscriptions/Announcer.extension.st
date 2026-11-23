Extension { #name : #Announcer }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Announcer >> useMixedSubscriptionRegistry [
	self useSubscriptionRegistry: GtMixedSubscriptionRegistry new
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Announcer >> useSubscriptionRegistry: aSubscriptionRegistry [
	| aWeakSubscriptionBuilder |
	aWeakSubscriptionBuilder := aSubscriptionRegistry
				weakSubscriptionBuilderFor: self.
	registry protected: 
			[registry subscriptions asArray do: 
					[:each |
					aSubscriptionRegistry
						add: (each subscriptionToMoveWith: aWeakSubscriptionBuilder)].
			registry := aSubscriptionRegistry]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Announcer >> weak [
	"announcer weak subscribe: foo"
	"GT patch: my registry chooses the weak builder, see implementors of #weakSubscriptionBuilderFor:"
	<gtPharoPatch: #Pharo>
	^registry weakSubscriptionBuilderFor: self
]
