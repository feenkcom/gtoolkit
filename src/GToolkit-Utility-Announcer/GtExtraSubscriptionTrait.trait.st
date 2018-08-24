Trait {
	#name : #GtExtraSubscriptionTrait,
	#category : 'GToolkit-Utility-Announcer'
}

{ #category : #'announcer - subscription' }
GtExtraSubscriptionTrait >> subscribe: anAnnouncementClass do: aValuable for: aSubscriber [
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	^ (self subscribe: anAnnouncementClass do: aValuable) subscriber: aSubscriber
]

{ #category : #'announcer - subscription' }
GtExtraSubscriptionTrait >> subscribe: anAnnouncementClass send: aSelector to: anObject for: aSubscriber [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."
	^ (self subscribe: anAnnouncementClass send: aSelector to: anObject) 
			subscriber: aSubscriber
]

{ #category : #'announcer - subscription' }
GtExtraSubscriptionTrait >> when: anAnnouncementClass doOnce: aValuable for: aSubscriber [
	"Declare that when anAnnouncementClass is raised, aValuable is executed and define the subscriber.
	A valuable is executed ONCE, and then a subscriber gets unsubscribed"
	^ self announcer
		when: anAnnouncementClass
		do: [ :anAnnouncement |
			self unsubscribe: aSubscriber.
			aValuable cull: anAnnouncement ]
		for: aSubscriber
]

{ #category : #'announcer - subscription' }
GtExtraSubscriptionTrait >> when: anAnnouncementClass send: aSelector to: anObject for: aSubscriber [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.
    When the message expects one argument (eg #fooAnnouncement:) the announcement is passed as argument.
    When the message expects two arguments (eg #fooAnnouncement:announcer:) both the announcement and the announcer 
    are passed as argument"
		^ (self announcer when: anAnnouncementClass send: aSelector to: anObject)
				subscriber: aSubscriber
]
