Trait {
	#name : #GtAnnouncingTrait,
	#category : 'GToolkit-Utility-Announcer'
}

{ #category : #'announcer - announce' }
GtAnnouncingTrait >> announce: anAnnouncement [
	^ self announcer announce: anAnnouncement
]

{ #category : #'announcer - accessing' }
GtAnnouncingTrait >> announcer [
	<return: #Announcer>
	^ self explicitRequirement
]
