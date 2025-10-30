Extension { #name : #SystemAnnouncer }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> announce: anAnnouncement [
	<gtPharoPatch: #Pharo12>
	^ self
		forPharo12AndNewer: [ (suspended not and: [ SystemAnnouncerSuspended value ]) ifTrue: [ ^ self ].
			^ super announce: anAnnouncement ]
		forPharo11: [ self isSuspended
				ifFalse: [ self private announce: anAnnouncement.
					super announce: anAnnouncement ]
				ifTrue: [ storedAnnouncements
						ifNotNil: [ storedAnnouncements add: anAnnouncement ] ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> localSuspendWhile: aBlock [
	^ SystemAnnouncerSuspended value: true during: aBlock
]
