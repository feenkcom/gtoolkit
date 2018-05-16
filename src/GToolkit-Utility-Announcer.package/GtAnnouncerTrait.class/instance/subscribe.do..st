subscription
subscribe: anAnnouncementClass do: aValuable 
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	^ self announcer subscribe: anAnnouncementClass do: aValuable 