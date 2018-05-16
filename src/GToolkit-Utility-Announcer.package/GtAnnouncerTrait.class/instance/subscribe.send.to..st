subscription
subscribe: anAnnouncementClass send: aSelector to: anObject
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."
	^ self announcer subscribe: anAnnouncementClass send: aSelector to: anObject