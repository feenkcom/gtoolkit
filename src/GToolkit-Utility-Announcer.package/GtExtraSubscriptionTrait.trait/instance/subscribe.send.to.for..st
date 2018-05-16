announcer - subscription
subscribe: anAnnouncementClass send: aSelector to: anObject for: aSubscriber
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."
	^ (self subscribe: anAnnouncementClass send: aSelector to: anObject) 
			subscriber: aSubscriber