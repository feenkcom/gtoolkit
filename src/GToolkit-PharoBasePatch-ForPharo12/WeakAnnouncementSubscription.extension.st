Extension { #name : #WeakAnnouncementSubscription }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
WeakAnnouncementSubscription >> unregister [

	GtWeakSubscriptionDisableFinalizationFlag isEnabled 
		ifTrue: [ ^ self ].
	
	self subscriber ifNotNil: [:sub | 
		self finalizationRegistry 
			remove: sub 
			ifAbsent: ["I will ignore if the subscription has been already removed"]]
]
