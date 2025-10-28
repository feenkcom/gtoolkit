Extension { #name : #SystemAnnouncer }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> announce: anAnnouncement [
	SystemAnnouncerSuspended value ifTrue: [ ^ self ].
	^ super announce: anAnnouncement
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> localSuspendWhile: aBlock [
	^ SystemAnnouncerSuspended value: true during: aBlock
]
