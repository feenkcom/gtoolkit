Extension { #name : #SystemAnnouncer }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> announce: anAnnouncement [
	<gtPharoPatch: #Pharo12>
	
	| aResult anInstance |
	(self isSuspended not and: [ SystemAnnouncerSuspended value ]) ifTrue: [ ^ self ].
	 
	anInstance := anAnnouncement asAnnouncement.
	aResult := super announce: anInstance.
	
	anInstance gtDoneAnnouncementIn: self.
	
	^ aResult
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
SystemAnnouncer >> localSuspendWhile: aBlock [
	^ SystemAnnouncerSuspended value: true during: aBlock
]
