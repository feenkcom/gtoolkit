announcement handling
handleEpiceaChangeImpact: anAnnouncement withGroup: aTabGroup diffTab: aDiffTab
	(anAnnouncement hasImpact and: [ (aTabGroup tabs identityIncludes: aDiffTab) not ])
		ifTrue: [ aTabGroup addTab: aDiffTab. ^ self ].
	(anAnnouncement hasImpact not and: [ (aTabGroup tabs identityIncludes: aDiffTab) ])
		ifTrue: [ aTabGroup removeTab: aDiffTab ].