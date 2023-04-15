Class {
	#name : #GtSpotterSubscriptionsShouldBeWeak,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtSpotterSubscriptionsShouldBeWeak >> description [
	^ 'Spotter subscriptions should be weak otherwise there are be mixed (weak and strong) subscriptions and weak subscriptions are not going to be garbage-collected.'
]

{ #category : #accessing }
GtSpotterSubscriptionsShouldBeWeak >> issues [
	<return: #OrderedCollection>
	^ '`@receiver
	when: `announcement `{:node | 
		node isGlobalVariable and: [ 
			| aClass |
			aClass := node binding value.
			aClass isClass and: [ 
				(aClass instanceSide inheritsFrom: GtSpotterAnnouncement) 
					or: [ aClass == GtSpotterAnnouncement ] ] ]  }
	do: ``@any' gtASTMatches result toArray wait
]

{ #category : #accessing }
GtSpotterSubscriptionsShouldBeWeak >> name [
	^ 'Spotter subscriptions should be weak'
]
