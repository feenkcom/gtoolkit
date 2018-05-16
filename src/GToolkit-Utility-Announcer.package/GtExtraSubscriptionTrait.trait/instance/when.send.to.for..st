announcer - subscription
when: anAnnouncementClass send: aSelector to: anObject for: aSubscriber
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.
    When the message expects one argument (eg #fooAnnouncement:) the announcement is passed as argument.
    When the message expects two arguments (eg #fooAnnouncement:announcer:) both the announcement and the announcer 
    are passed as argument"
		^ (self announcer when: anAnnouncementClass send: aSelector to: anObject)
				subscriber: aSubscriber