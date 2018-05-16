announcer - subscription
subscribe: anAnnouncementClass do: aValuable for: aSubscriber
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	^ (self subscribe: anAnnouncementClass do: aValuable) subscriber: aSubscriber