Class {
	#name : #GtAnnouncementSubscriberShouldNotBeChanged,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtAnnouncementSubscriberShouldNotBeChanged >> issues [
	"returns the facts that contradict the constraint"
	^ FastSubscriptionRegistry allInstances reject: [ :eachRegistry |
		eachRegistry subscriptions allSatisfy: [ :subscription |
			eachRegistry hasSubscriber: subscription subscriber ] ]
]

{ #category : #accessing }
GtAnnouncementSubscriberShouldNotBeChanged >> name [
	^ 'Subscribers should not be changed after creating a subscription'
]
