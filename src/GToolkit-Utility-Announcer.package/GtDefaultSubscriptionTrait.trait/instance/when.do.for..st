announcer - subscription
when: anAnnouncementClass do: aValuable for: aSubscriber
	"Declare that when anAnnouncementClass is raised, aValuable is executed and define the subscriber."
		^ self announcer when: anAnnouncementClass do: aValuable for: aSubscriber