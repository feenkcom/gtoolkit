announcement handling
handleEpiceaChangeImpact: anAnnouncement withGroup: aTabGroup diffTab: aDiffTab

	anAnnouncement hasImpact
		ifTrue: [ (aTabGroup hasTab: aDiffTab)
			ifFalse: [ aTabGroup addTab: aDiffTab ] ]
		ifFalse: [ (aTabGroup hasTab: aDiffTab)
			ifTrue: [ aTabGroup removeTab: aDiffTab ] ]