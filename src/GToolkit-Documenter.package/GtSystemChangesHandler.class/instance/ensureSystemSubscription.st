private
ensureSystemSubscription
	isRegistered ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: SystemAnnouncement
		send: #handleSystemChange:
		to: self.
	isRegistered := true.