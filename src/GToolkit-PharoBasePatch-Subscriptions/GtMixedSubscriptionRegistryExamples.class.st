"
I show how {{gtClass:GtMixedSubscriptionRegistry}} delivers announcements, stays compatible with the announcement framework and lets subscribers be garbage collected. The protocols group the examples: ""examples - basic"" and ""examples - delivery"" for subscribing, unsubscribing and matching, ""examples - compatibility"" for behaviour shared with Pharo's registries, ""examples - plain registries"" for the patched {{gtMethod:Announcer>>#weak}} and {{gtMethod:AnnouncementSubscription>>#makeWeak}} keeping the Pharo behaviour of {{gtClass:SubscriptionRegistry}} and {{gtClass:FastSubscriptionRegistry}}, and ""examples - lazy weak part"", ""examples - mourning"", ""examples - garbage collection"" and ""examples - concurrency"" for the inner workings.
The examples in ""examples - garbage collection"" and ""examples - concurrency"" force garbage collections or run workers for several seconds. Run many of them in a forked process at user priority or lower.
"
Class {
	#name : #GtMixedSubscriptionRegistryExamples,
	#superclass : #Object,
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Examples'
}

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> announcementIsPreparedOnlyWhenSomeoneHandlesIt [
	<gtExample>
	| anAnnouncer anAnnouncement |
	anAnnouncer := self announcerWithMixedRegistry.
	anAnnouncer weak
		when: JobStart
		send: #onAnnouncement:
		to: self newSubscriber.
	anAnnouncement := GtMixedSubscriptionRegistryExampleAnnouncement new.
	anAnnouncer announce: anAnnouncement.
	self assert: anAnnouncement preparations equals: 0.
	anAnnouncer weak
		when: GtMixedSubscriptionRegistryExampleAnnouncement
		send: #onAnnouncement:
		to: self newSubscriber.
	anAnnouncer
		when: GtMixedSubscriptionRegistryExampleAnnouncement
		send: #onAnnouncement:
		to: self newSubscriber.
	anAnnouncer announce: anAnnouncement.
	self assert: anAnnouncement preparations equals: 1.
	anAnnouncer announce: anAnnouncement.
	self assert: anAnnouncement preparations equals: 2.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> announcerIsCollectedWhileWeakSubscriberLives [
	<gtExample>
	| aSubscriber theSurvivors |
	aSubscriber := self newSubscriber.
	theSurvivors := self announcerWithWeakSubscriber: aSubscriber.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: aSubscriber announcements isEmpty.
	^theSurvivors
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> announcerWithMixedRegistry [
	<gtExample>
	| anAnnouncer |
	anAnnouncer := self newAnnouncer.
	self assert: anAnnouncer subscriptions class
		equals: GtMixedSubscriptionRegistry.
	self assert: anAnnouncer weak class equals: GtEphemeronSubscriptionBuilder.
	self assert: anAnnouncer weak weak class
		equals: GtEphemeronSubscriptionBuilder.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> announcerWithWeakSubscriber: aSubscriber [
	| anAnnouncer |
	anAnnouncer := self newAnnouncer.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	^WeakArray with: anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> announcingAClassOrAnInstanceAnswersTheDeliveredAnnouncement [
	<gtExample>
	| anAnnouncer aSubscriber anAnnouncement |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (anAnnouncer announce: JobStart) class equals: JobStart.
	anAnnouncement := JobStart new.
	self assert: (anAnnouncer announce: anAnnouncement) == anAnnouncement.
	self assert: aSubscriber announcements size equals: 2.
	self assert: aSubscriber announcements first class equals: JobStart.
	self assert: aSubscriber announcements last == anAnnouncement.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> announcingFromAHandlerIsReentrant [
	<gtExample>
	| anAnnouncer aSubscriber anotherSubscriber theCalls |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	theCalls := 0.
	anAnnouncer weak
		when: JobStart
		do: 
			[:anAnnouncement |
			theCalls := theCalls + 1.
			theCalls = 1 ifTrue: [anAnnouncer announce: JobStart new]]
		for: aSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anotherSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: theCalls equals: 2.
	self assert: anotherSubscriber announcements size equals: 2.
	^anAnnouncer
]

{ #category : #'private - delivery' }
GtMixedSubscriptionRegistryExamples >> assertChange: aChangeBlock named: aName isNotedBy: aRegistry [
	| aLastChange |
	aLastChange := aRegistry lastChange.
	aChangeBlock value.
	self assert: aRegistry lastChange ~~ aLastChange
		description: [aName , ' was not noted as a change']
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> assertChange: aChangeBlock named: aName waitsForTheLockOf: anAnnouncer [
	| aRegistry aWorker isFinished theStateBefore |
	aRegistry := anAnnouncer subscriptions.
	isFinished := Semaphore new.
	aRegistry protected: 
			[theStateBefore := self stateOf: aRegistry.
			aWorker := 
					[aChangeBlock value.
					isFinished signal]
							forkAt: Processor activePriority + 1.
			self assert: aWorker isTerminated not
				description: [aName , ' did not wait for the lock'].
			self assert: (self stateOf: aRegistry) = theStateBefore
				description: [aName , ' changed the registry while its lock was held']].
	self assert: (isFinished waitTimeoutMilliseconds: 5000) not
		description: [aName , ' did not finish after the lock was released'].
	self assert: (self stateOf: aRegistry) ~= theStateBefore
		description: [aName , ' did not change the registry']
]

{ #category : #'private - delivery' }
GtMixedSubscriptionRegistryExamples >> assertQuery: aQueryBlock named: aName isNotNotedBy: aRegistry [
	| aLastChange |
	aLastChange := aRegistry lastChange.
	aQueryBlock value.
	self assert: aRegistry lastChange == aLastChange
		description: [aName , ' was noted as a change']
]

{ #category : #'private - weak part' }
GtMixedSubscriptionRegistryExamples >> assertWeakPartInvariantOf: aRegistry [
	aRegistry protected: 
			[self assert: aRegistry weakPart isEmpty = (self hasNoWeakPart: aRegistry)
				description: 
					['The weak part must be the shared empty part exactly when it is empty']]
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> changingTheSubscriberRefilesTheSubscription [
	<gtExample>
	| anAnnouncer aFirstSubscriber aSecondSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aFirstSubscriber := self newSubscriber.
	aSecondSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aFirstSubscriber.
	self
		assert: (aSubscription subscriber: aSecondSubscriber) == aSubscription.
	self assert: aSubscription subscriber == aSecondSubscriber.
	self assert: (anAnnouncer hasSubscriber: aSecondSubscriber).
	self assert: (anAnnouncer hasSubscriber: aFirstSubscriber) not.
	self
		assert: (anAnnouncer subscriptions ephemeronOf: aFirstSubscriber) isNil.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aFirstSubscriber announcements size equals: 1.
	anAnnouncer unsubscribe: aSecondSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> changingTheSubscriberToNilSignalsError [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription isSignalled |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	isSignalled := false.
	[aSubscription subscriber: nil] on: Error
		do: [:anError | isSignalled := true].
	self assert: isSignalled.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: (anAnnouncer hasSubscriber: aSubscriber).
	self
		assert: (anAnnouncer subscriptions weakSubscribersWithSubscriptions
				collect: [:each | each key]) asArray
		equals: (Array with: aSubscriber).
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> changingTheSubscriberToTheActionSignalsError [
	<gtExample>
	| anAnnouncer aSubscriber aBlock aSubscription isSignalled |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aBlock := [:anAnnouncement | aSubscriber onAnnouncement: anAnnouncement].
	aSubscription := anAnnouncer weak when: JobStart do: aBlock for: aSubscriber.
	isSignalled := false.
	[aSubscription subscriber: aBlock] on: Error
		do: [:anError | isSignalled := true].
	self assert: isSignalled.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: (anAnnouncer hasSubscriber: aSubscriber).
	^anAnnouncer
]

{ #category : #'examples - concurrency' }
GtMixedSubscriptionRegistryExamples >> concurrentMourningKeepsAResubscribingSubscriber [
	<gtExample>
	| anAnnouncer aLongLivedSubscriber aDeadline theWorkers theErrors |
	anAnnouncer := self newAnnouncer.
	aLongLivedSubscriber := self newSubscriber.
	aDeadline := Time millisecondClockValue + 3000.
	theWorkers := OrderedCollection new.
	2 timesRepeat: 
			[theWorkers
				add: 31 -> 
							[[Time millisecondClockValue < aDeadline] whileTrue: 
									[anAnnouncer weak
										when: JobStart
										send: #onAnnouncement:
										to: self newSubscriber.
									self pauseBetweenRounds: false]]].
	theWorkers
		add: 33 -> 
					[[Time millisecondClockValue < aDeadline] whileTrue: 
							[| aCount |
							anAnnouncer weak
								when: JobEnd
								send: #onAnnouncement:
								to: aLongLivedSubscriber.
							aCount := aLongLivedSubscriber announcements size.
							anAnnouncer announce: JobEnd new.
							self assert: aLongLivedSubscriber announcements size equals: aCount + 1.
							anAnnouncer unsubscribe: aLongLivedSubscriber.
							self assert: (anAnnouncer hasSubscriber: aLongLivedSubscriber) not.
							self pauseBetweenRounds: true].
					anAnnouncer weak
						when: JobEnd
						send: #onAnnouncement:
						to: aLongLivedSubscriber].
	theWorkers
		add: 36 -> (self readerOf: (Array with: anAnnouncer) until: aDeadline).
	theWorkers add: 37 -> (self scavengerUntil: aDeadline).
	theErrors := self runWorkers: theWorkers until: aDeadline.
	self assert: theErrors isEmpty description: [theErrors printString].
	self assert: (self
				garbageCollectUntil: [anAnnouncer subscriptions numberOfWeakSubscribers = 1]).
	self assert: (anAnnouncer hasSubscriber: aLongLivedSubscriber).
	anAnnouncer announce: JobEnd new.
	self assert: aLongLivedSubscriber announcements last class equals: JobEnd.
	anAnnouncer unsubscribe: aLongLivedSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	^anAnnouncer
]

{ #category : #'examples - concurrency' }
GtMixedSubscriptionRegistryExamples >> concurrentWeakSubscriptionsKeepTheRegistryConsistent [
	<gtExample>
	| theAnnouncers aLock theDeliveries theAnnounced theRounds aDeadline aChurn theWorkers theErrors |
	theAnnouncers := Array with: self newAnnouncer with: self newAnnouncer.
	aLock := Mutex new.
	theDeliveries := 0.
	theAnnounced := 0.
	theRounds := 0.
	theAnnouncers do: 
			[:anAnnouncer |
			anAnnouncer
				when: JobStart
				do: [:anAnnouncement | aLock critical: [theDeliveries := theDeliveries + 1]]
				for: self].
	aDeadline := Time millisecondClockValue + 3000.
	aChurn :=
			[:shouldPause |
			| aRound |
			aRound := 0.
			[Time millisecondClockValue < aDeadline] whileTrue: 
					[| anAnnouncer aSubscriber theReceived |
					aRound := aRound + 1.
					anAnnouncer := theAnnouncers at: aRound \\ 2 + 1.
					aSubscriber := Object new.
					theReceived := 0.
					anAnnouncer weak
						when: JobStart
						do: [:anAnnouncement | theReceived := theReceived + 1]
						for: aSubscriber.
					anAnnouncer announce: JobStart new.
					aLock critical: [theAnnounced := theAnnounced + 1].
					self assert: theReceived >= 1.
					aRound \\ 3 = 0
						ifFalse: 
							[anAnnouncer unsubscribe: aSubscriber.
							self assert: (anAnnouncer hasSubscriber: aSubscriber) not].
					self pauseBetweenRounds: shouldPause].
			aLock critical: [theRounds := theRounds + aRound]].
	theWorkers := OrderedCollection new.
	2 timesRepeat: [theWorkers add: 31 -> [aChurn value: false]].
	33 to: 35
		do: [:aPriority | theWorkers add: aPriority -> [aChurn value: true]].
	theWorkers add: 36 -> (self readerOf: theAnnouncers until: aDeadline).
	theWorkers add: 36 -> (self copierOf: theAnnouncers until: aDeadline).
	theWorkers add: 37 -> (self scavengerUntil: aDeadline).
	theErrors := self runWorkers: theWorkers until: aDeadline.
	self assert: theErrors isEmpty description: [theErrors printString].
	self assert: theRounds > 1000.
	self assert: theDeliveries equals: theAnnounced.
	self
		assert: (self garbageCollectUntil: 
					[theAnnouncers
						allSatisfy: [:each | each subscriptions numberOfWeakSubscribers = 0]]).
	theAnnouncers do: 
			[:each |
			self assert: (self hasNoWeakPart: each subscriptions).
			self assert: each numberOfSubscriptions equals: 1].
	self assert: GtNoWeakSubscriptions uniqueInstance isEmpty.
	^theAnnouncers
]

{ #category : #'examples - delivery' }
GtMixedSubscriptionRegistryExamples >> conditionIsEvaluatedAsOftenAsInAPlainRegistry [
	<gtExample>
	| theMixedEvaluations |
	theMixedEvaluations := self
				evaluationsOfAConditionAnnouncedIn: self announcerWithMixedRegistry.
	self assert: theMixedEvaluations
		equals: (self evaluationsOfAConditionAnnouncedIn: Announcer new).
	^theMixedEvaluations
]

{ #category : #'examples - delivery' }
GtMixedSubscriptionRegistryExamples >> conditionThatChangesTheRegistryIsMatchedAgain [
	<gtExample>
	| anAnnouncer aSubscriber anotherSubscriber theEvaluations |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	theEvaluations := 0.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anotherSubscriber.
	anAnnouncer weak
		when: (JobStart where: 
					[:anAnnouncement |
					theEvaluations := theEvaluations + 1.
					theEvaluations = 1
						ifTrue: 
							[anAnnouncer
								when: JobEnd
								send: #onAnnouncement:
								to: self newSubscriber].
					true])
		send: #onAnnouncement:
		to: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: theEvaluations
		equals: (self
				evaluationsOfAConditionAnnouncedIn: self announcerWithMixedRegistry) + 1.
	self assert: aSubscriber announcements size equals: 1.
	self assert: anotherSubscriber announcements size equals: 1.
	self assert: anAnnouncer numberOfSubscriptions equals: 3.
	^anAnnouncer
]

{ #category : #'examples - delivery' }
GtMixedSubscriptionRegistryExamples >> conditionThatUnsubscribesAnotherSubscriberIsRespected [
	<gtExample>
	| anAnnouncer aSubscriber aLeavingSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aLeavingSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aLeavingSubscriber.
	anAnnouncer weak
		when: (JobStart where: 
					[:anAnnouncement |
					anAnnouncer unsubscribe: aLeavingSubscriber.
					true])
		send: #onAnnouncement:
		to: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	self assert: aLeavingSubscriber announcements isEmpty.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> copiedRegistryAcceptsWeakSubscriptions [
	<gtExample>
	| anAnnouncer aSubscriber aCopy |
	aCopy := GtMixedSubscriptionRegistry new veryDeepCopy.
	self assert: aCopy weakPart isEmpty.
	anAnnouncer := Announcer new useSubscriptionRegistry: aCopy.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: (self hasNoWeakPart: aCopy).
	self assert: GtNoWeakSubscriptions uniqueInstance isEmpty.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> copiedRegistryIsIndependent [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aCopy anotherAnnouncer aLateSubscriber |
	anAnnouncer := self newAnnouncer.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	aCopy := anAnnouncer subscriptions copy.
	anotherAnnouncer := Announcer new useSubscriptionRegistry: aCopy.
	self assert: aCopy numberOfSubscriptions equals: 2.
	self assert: aCopy numberOfWeakSubscribers equals: 1.
	self assert: aCopy weakPart ~~ anAnnouncer subscriptions weakPart.
	self assert: (aCopy ephemeronOf: aWeakSubscriber)
				~~ (anAnnouncer subscriptions ephemeronOf: aWeakSubscriber).
	anotherAnnouncer announce: JobStart new.
	self assert: aStrongSubscriber announcements size equals: 1.
	self assert: aWeakSubscriber announcements size equals: 1.
	anotherAnnouncer unsubscribe: aWeakSubscriber.
	self assert: (self hasNoWeakPart: aCopy).
	self assert: (anAnnouncer hasSubscriber: aWeakSubscriber).
	aLateSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aLateSubscriber.
	self assert: (anotherAnnouncer hasSubscriber: aLateSubscriber) not.
	anotherAnnouncer unsubscribe: aStrongSubscriber.
	self assert: (anAnnouncer hasSubscriber: aStrongSubscriber).
	self assertWeakPartInvariantOf: aCopy.
	self assertWeakPartInvariantOf: anAnnouncer subscriptions.
	^aCopy
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> copiedRegistryMournsItsOwnEphemerons [
	<gtExample>
	| anAnnouncer aCopy theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	aCopy := anAnnouncer subscriptions copy.
	self assert: aCopy numberOfWeakSubscribers equals: 1.
	self
		assert: (self garbageCollectUntil: 
					[anAnnouncer subscriptions isEmpty
						and: [aCopy isEmpty and: [(theSurvivors at: 1) isNil]]]).
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	self assert: (self hasNoWeakPart: aCopy).
	^aCopy
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> copierOf: theAnnouncers until: aDeadline [
	^
	[[Time millisecondClockValue < aDeadline] whileTrue: 
			[theAnnouncers do: 
					[:anAnnouncer |
					| aCopy |
					aCopy := anAnnouncer subscriptions copy.
					self assertWeakPartInvariantOf: aCopy.
					self assert: aCopy allStrongSubscriptions notEmpty.
					self assert: aCopy numberOfSubscriptions equals: aCopy subscriptions size].
			(Delay forMilliseconds: 2) wait]]
]

{ #category : #'private - weak part' }
GtMixedSubscriptionRegistryExamples >> decrease: aSubscriber in: theExpected [
	| aCount |
	aCount := (theExpected at: aSubscriber) - 1.
	aCount = 0
		ifTrue: [theExpected removeKey: aSubscriber]
		ifFalse: [theExpected at: aSubscriber put: aCount]
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> elementOfModelIsCollectedDespiteLiveWeakSubscriber [
	<gtExample>
	| anExtraSubscriber theSurvivors |
	anExtraSubscriber := self newSubscriber.
	theSurvivors := self
				modelAndElementWithStrongSubscriptionOn: self newAnnouncer
				extraWeakSubscriber: anExtraSubscriber.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	self assert: anExtraSubscriber announcements isEmpty.
	^theSurvivors
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> elementOfModelLeaksWithPlainRegistry [
	<gtExample>
	| anExtraSubscriber theSurvivors |
	anExtraSubscriber := self newSubscriber.
	theSurvivors := self
				modelAndElementWithStrongSubscriptionOn: Announcer new
				extraWeakSubscriber: anExtraSubscriber.
	self garbageCollect.
	self assert: (theSurvivors at: 1) notNil.
	self assert: (theSurvivors at: 2) notNil.
	self assert: anExtraSubscriber announcements isEmpty.
	^theSurvivors
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> emptyRegistriesShareTheEmptyWeakPart [
	<gtExample>
	| aRegistry anotherRegistry |
	aRegistry := GtMixedSubscriptionRegistry new.
	anotherRegistry := GtMixedSubscriptionRegistry new.
	self assert: (self hasNoWeakPart: aRegistry).
	self assert: (self hasNoWeakPart: anotherRegistry).
	self assert: aRegistry weakPart == anotherRegistry weakPart.
	^aRegistry
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> emptyRegistry [
	<gtExample>
	| aRegistry |
	aRegistry := GtMixedSubscriptionRegistry new.
	self assert: aRegistry isEmpty.
	self assert: aRegistry numberOfSubscriptions equals: 0.
	self assert: aRegistry subscriptions isEmpty.
	self assert: aRegistry numberOfWeakSubscribers equals: 0.
	^aRegistry
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> emptyWeakPartHasNoState [
	<gtExample>
	| theEmptyPart aSubscriber anEphemeron aPart |
	theEmptyPart := GtNoWeakSubscriptions uniqueInstance.
	self assert: GtNoWeakSubscriptions instSize equals: 0.
	self assert: theEmptyPart == GtNoWeakSubscriptions uniqueInstance.
	aSubscriber := self newSubscriber.
	anEphemeron := WeakKeyAssociation key: aSubscriber
				value: (IdentitySet with: #aSubscription).
	self assert: theEmptyPart isEmpty.
	self assert: theEmptyPart numberOfSubscribers equals: 0.
	self assert: theEmptyPart numberOfSubscriptions equals: 0.
	self assert: (theEmptyPart ephemeronOf: aSubscriber) isNil.
	self
		assert: (theEmptyPart subscriptionsOf: aSubscriber ifAbsent: [#absent])
		equals: #absent.
	self assert: theEmptyPart subscribersWithSubscriptions isEmpty.
	self assert: (theEmptyPart withoutSubscriber: aSubscriber) == theEmptyPart.
	self assert: (theEmptyPart withoutEphemeron: anEphemeron) == theEmptyPart.
	aPart := theEmptyPart withEphemeron: anEphemeron.
	self assert: aPart ~~ theEmptyPart.
	self assert: aPart numberOfSubscriptions equals: 1.
	self assert: theEmptyPart isEmpty.
	^theEmptyPart
]

{ #category : #'private - delivery' }
GtMixedSubscriptionRegistryExamples >> evaluationsOfAConditionAnnouncedIn: anAnnouncer [
	| aSubscriber theEvaluations |
	aSubscriber := self newSubscriber.
	theEvaluations := 0.
	anAnnouncer weak
		when: (JobStart where: 
					[:anAnnouncement |
					theEvaluations := theEvaluations + 1.
					true])
		send: #onAnnouncement:
		to: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^theEvaluations
]

{ #category : #'examples - delivery' }
GtMixedSubscriptionRegistryExamples >> everyChangeOfTheRegistryIsNoted [
	<gtExample>
	| anAnnouncer aRegistry aSubscriber anotherSubscriber aSubscription aStrongSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aRegistry := anAnnouncer subscriptions.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	self
		assertChange: 
			[anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber]
		named: 'The first weak subscription'
		isNotedBy: aRegistry.
	self
		assertChange: 
			[aSubscription := anAnnouncer weak
						when: JobEnd
						send: #onAnnouncement:
						to: aSubscriber]
		named: 'A second weak subscription of the same subscriber'
		isNotedBy: aRegistry.
	self
		assertChange: [anAnnouncer removeSubscription: aSubscription]
		named: 'Removing a weak subscription that is not the last of its subscriber'
		isNotedBy: aRegistry.
	self
		assertChange: 
			[aStrongSubscription := anAnnouncer
						when: JobStart
						send: #onAnnouncement:
						to: anotherSubscriber]
		named: 'A strong subscription'
		isNotedBy: aRegistry.
	self
		assertChange: [anAnnouncer removeSubscription: aStrongSubscription]
		named: 'Removing a strong subscription'
		isNotedBy: aRegistry.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anotherSubscriber.
	self
		assertChange: [anAnnouncer unsubscribe: anotherSubscriber]
		named: 'Unsubscribing a strong subscriber'
		isNotedBy: aRegistry.
	aSubscription := anAnnouncer weak
				when: JobEnd
				send: #onAnnouncement:
				to: aSubscriber.
	self
		assertChange: [aSubscription subscriber: anotherSubscriber]
		named: 'Changing the subscriber'
		isNotedBy: aRegistry.
	self
		assertChange: [aSubscription makeStrong]
		named: 'Making a weak subscription strong'
		isNotedBy: aRegistry.
	aStrongSubscription := anAnnouncer
				when: JobEnd
				send: #onAnnouncement:
				to: self newSubscriber.
	self
		assertChange: [aStrongSubscription makeWeak]
		named: 'Making a strong subscription weak'
		isNotedBy: aRegistry.
	self
		assertChange: [(aRegistry ephemeronOf: aSubscriber) mourn]
		named: 'Mourning a weak subscriber'
		isNotedBy: aRegistry.
	self
		assertChange: [anAnnouncer unsubscribe: anotherSubscriber]
		named: 'Unsubscribing a subscriber'
		isNotedBy: aRegistry.
	self
		assertChange: [aRegistry reset]
		named: 'Resetting the registry'
		isNotedBy: aRegistry.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	self
		assertQuery: [anAnnouncer announce: JobStart new]
		named: 'Delivering an announcement'
		isNotNotedBy: aRegistry.
	self
		assertQuery: 
			[aRegistry subscriptions.
			aRegistry numberOfSubscriptions.
			aRegistry subscriptionsHandling: JobStart new]
		named: 'Querying the subscriptions'
		isNotNotedBy: aRegistry.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - concurrency' }
GtMixedSubscriptionRegistryExamples >> everyChangeOfTheRegistryWaitsForItsLock [
	<gtExample>
	| anAnnouncer aSubscriber anotherSubscriber aSubscription anEphemeron |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	self
		assertChange: 
			[anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber]
		named: 'The first weak subscription'
		waitsForTheLockOf: anAnnouncer.
	self
		assertChange: 
			[anAnnouncer when: JobStart send: #onAnnouncement: to: anotherSubscriber]
		named: 'A strong subscription'
		waitsForTheLockOf: anAnnouncer.
	self
		assertChange: [anAnnouncer unsubscribe: aSubscriber]
		named: 'Unsubscribing the last weak subscriber'
		waitsForTheLockOf: anAnnouncer.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self
		assertChange: [anAnnouncer removeSubscription: aSubscription]
		named: 'Removing the last weak subscription'
		waitsForTheLockOf: anAnnouncer.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self
		assertChange: [aSubscription subscriber: self newSubscriber]
		named: 'Changing the subscriber'
		waitsForTheLockOf: anAnnouncer.
	self
		assertChange: [aSubscription makeStrong]
		named: 'Making the last weak subscription strong'
		waitsForTheLockOf: anAnnouncer.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	anEphemeron := anAnnouncer subscriptions ephemeronOf: aSubscriber.
	self
		assertChange: [anEphemeron mourn]
		named: 'Mourning the last weak subscriber'
		waitsForTheLockOf: anAnnouncer.
	self
		assertChange: [anAnnouncer subscriptions reset]
		named: 'Resetting the registry'
		waitsForTheLockOf: anAnnouncer.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> fastRegistryAnswersWeakSubscriptionBuilder [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := Announcer new
				useSubscriptionRegistry: FastSubscriptionRegistry new.
	aSubscriber := self newSubscriber.
	self assert: anAnnouncer subscriptions class
		equals: FastSubscriptionRegistry.
	self assert: anAnnouncer weak class equals: WeakSubscriptionBuilder.
	self
		assert: (anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber) class
		equals: WeakAnnouncementSubscription.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> fastRegistryClassifiesStrongAndWeakSubscriptions [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber |
	anAnnouncer := Announcer new
				useSubscriptionRegistry: FastSubscriptionRegistry new.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix not.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self assert: anAnnouncer subscriptions allStrongSubscriptions size
		equals: 1.
	self assert: anAnnouncer subscriptions allWeakSubscriptions size equals: 1.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> fastRegistryMakeWeakKeepsPharoBehaviour [
	<gtExample>
	| anAnnouncer aSubscriber aMadeWeak anErrorText |
	anAnnouncer := Announcer new
				useSubscriptionRegistry: FastSubscriptionRegistry new.
	aSubscriber := self newSubscriber.
	aMadeWeak := (anAnnouncer
				when: JobEnd
				send: #onAnnouncement:
				to: aSubscriber) makeWeak.
	self assert: aMadeWeak class equals: WeakAnnouncementSubscription.
	self assert: aMadeWeak action class equals: WeakMessageSend.
	anErrorText := 
			[(anAnnouncer
				when: JobStart
				do: [:anAnnouncement | ]
				for: aSubscriber) makeWeak.
			nil]
					on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'Not currently available due to missing ephemerons support'.
	self assert: anAnnouncer numberOfSubscriptions equals: 2.
	anAnnouncer announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> firstCollectionMournsTheEntry [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	Smalltalk garbageCollect.
	self assert: (self
				waitUntil: [anAnnouncer subscriptions numberOfWeakSubscribers = 0]).
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> firstWeakSubscriptionCreatesOwnWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	self assert: GtNoWeakSubscriptions uniqueInstance isEmpty.
	self assert: (self hasNoWeakPart: GtMixedSubscriptionRegistry new).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'private - delivery' }
GtMixedSubscriptionRegistryExamples >> forkChangeOf: anAnnouncer [
	^
	[anAnnouncer
		when: JobEnd
		send: #onAnnouncement:
		to: self newSubscriber]
			forkAt: Processor activePriority + 1
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> fuelMaterializedRegistrySharesTheEmptyWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber aCopy |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aCopy := FLMaterializer
				materializeFromByteArray: (FLSerializer serializeToByteArray: anAnnouncer).
	self assert: (self hasNoWeakPart: aCopy subscriptions).
	aCopy weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (self hasOwnWeakPart: aCopy subscriptions).
	aCopy announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^aCopy
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> fuelRoundTripKeepsStrongSubscriptions [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aCopy |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	aCopy := FLMaterializer
				materializeFromByteArray: (FLSerializer serializeToByteArray: anAnnouncer).
	self assert: aCopy subscriptions class equals: GtMixedSubscriptionRegistry.
	self assert: aCopy numberOfSubscriptions equals: 1.
	self assert: aCopy subscriptions numberOfWeakSubscribers equals: 0.
	aCopy announce: JobStart new.
	self
		assert: aCopy subscriptions allStrongSubscriptions first subscriber
				announcements size
		equals: 1.
	self assert: aStrongSubscriber announcements isEmpty.
	aCopy weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self assert: aCopy numberOfSubscriptions equals: 2.
	^aCopy
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> garbageCollect [
	2 timesRepeat: [Smalltalk garbageCollect]
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> garbageCollectUntil: aBlock [
	| aDeadline |
	aDeadline := Time millisecondClockValue + 40000.
	
	[Smalltalk garbageCollect.
	aBlock value] whileFalse: 
				[Time millisecondClockValue > aDeadline ifTrue: [^false].
				(Delay forMilliseconds: 10) wait].
	^true
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> hasFinalizationRegistryEntryFor: anObject [
	FinalizationRegistry default ephemeronAtKey: anObject ifAbsent: [^false].
	^true
]

{ #category : #'private - weak part' }
GtMixedSubscriptionRegistryExamples >> hasNoWeakPart: aRegistry [
	^aRegistry weakPart == GtNoWeakSubscriptions uniqueInstance
]

{ #category : #'private - weak part' }
GtMixedSubscriptionRegistryExamples >> hasOwnWeakPart: aRegistry [
	^(self hasNoWeakPart: aRegistry) not
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> heldWeakSubscriptionDoesNotKeepItsSubscriberAlive [
	<gtExample>
	| anAnnouncer aHolder theSurvivors |
	anAnnouncer := self newAnnouncer.
	aHolder := OrderedCollection new.
	theSurvivors := self weakSubscriptionHeldBy: aHolder on: anAnnouncer.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	self assert: aHolder first subscriber isNil.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> heldWeakSubscriptionOfPlainAnnouncerDoesNotKeepItsSubscriber [
	<gtExample>
	| anAnnouncer aHolder theSurvivors |
	anAnnouncer := Announcer new.
	aHolder := OrderedCollection new.
	theSurvivors := self weakSubscriptionHeldBy: aHolder on: anAnnouncer.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer numberOfSubscriptions = 0]).
	self assert: aHolder first subscriber isNil.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> heldWeakSubscriptionWithBlockActionKeepsItsSubscriberAlive [
	<gtExample>
	| anAnnouncer aHolder theSurvivors |
	anAnnouncer := self newAnnouncer.
	aHolder := OrderedCollection new.
	theSurvivors := self weakSubscriptionWithBlockActionHeldBy: aHolder
				on: anAnnouncer.
	self garbageCollect.
	self assert: (theSurvivors at: 1) notNil.
	aHolder removeAll.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> lockIsReentrant [
	<gtExample>
	| anAnnouncer aSubscriber theSubscriptions |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	theSubscriptions := anAnnouncer subscriptions
				protected: [anAnnouncer subscriptions subscriptions copy asArray].
	self assert: theSubscriptions size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> madeWeakSubscriberIsGarbageCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeStrongThenMakeWeakTo: anAnnouncer.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> makeStrongMovesWeakSubscriptionToStrongPart [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription aStrongSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	aStrongSubscription := aSubscription makeStrong.
	self assert: aSubscription == aStrongSubscription.
	self assert: aStrongSubscription class equals: AnnouncementSubscription.
	self assert: aStrongSubscription subscriber == aSubscriber.
	self assert: aStrongSubscription action class equals: MessageSend.
	self assert: anAnnouncer subscriptions allStrongSubscriptions
		equals: (Array with: aStrongSubscription).
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 0.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	anAnnouncer removeSubscription: aSubscription.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> makeStrongOfADeadWeakSubscriptionSignalsError [
	<gtExample>
	| anAnnouncer aSubscription anErrorText |
	anAnnouncer := self newAnnouncer.
	aSubscription := self weakSubscriptionOfDyingSubscriberOn: anAnnouncer.
	self assert: (self garbageCollectUntil: [aSubscription subscriber isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	anErrorText := 
			[aSubscription makeStrong.
			nil] on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'Subscriber is nil, cannot make strong subscription'.
	self assert: aSubscription class
		equals: GtEphemeronAnnouncementSubscription.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> makeStrongOfTheLastWeakSubscriptionReleasesTheWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	aSubscription makeStrong.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> makeWeakInMixedRegistryBuildsEphemeronSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aStrongSubscription aWeakSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aStrongSubscription := anAnnouncer
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	aWeakSubscription := aStrongSubscription makeWeak.
	self assert: aWeakSubscription class
		equals: GtEphemeronAnnouncementSubscription.
	self assert: aWeakSubscription subscriber == aSubscriber.
	self assert: aWeakSubscription action class equals: WeakMessageSend.
	self assert: aWeakSubscription action receiver == aSubscriber.
	self assert: anAnnouncer subscriptions allStrongSubscriptions isEmpty.
	self assert: anAnnouncer subscriptions allWeakSubscriptions
		equals: (Array with: aWeakSubscription).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> makeWeakInMixedRegistrySupportsBlockActions [
	<gtExample>
	| anAnnouncer aSubscriber aWeakSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aWeakSubscription := (anAnnouncer
				when: JobStart
				do: [:anAnnouncement | aSubscriber onAnnouncement: anAnnouncement]
				for: aSubscriber) makeWeak.
	self assert: aWeakSubscription class
		equals: GtEphemeronAnnouncementSubscription.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> makeWeakOfAValuableThatIsItsOwnSubscriberSignalsError [
	<gtExample>
	| anAnnouncer aBlock aSubscription anErrorText |
	anAnnouncer := self announcerWithMixedRegistry.
	aBlock := [:anAnnouncement | anAnnouncement].
	aSubscription := anAnnouncer when: JobStart do: aBlock for: aBlock.
	anErrorText := 
			[aSubscription makeWeak.
			nil] on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'A valuable that is its own subscriber cannot be subscribed weakly'.
	self assert: anAnnouncer subscriptions allStrongSubscriptions
		equals: (Array with: aSubscription).
	^anAnnouncer
]

{ #category : #'examples - delivery' }
GtMixedSubscriptionRegistryExamples >> matchingHoldsTheLockAndDeliveryDoesNot [
	<gtExample>
	| anAnnouncer aSubscriber theStatesWhileMatching wasFreeWhileDelivering |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	theStatesWhileMatching := OrderedCollection new.
	anAnnouncer
		when: (JobStart where: 
					[:anAnnouncement |
					theStatesWhileMatching isEmpty
						ifTrue: 
							[theStatesWhileMatching
								add: (self forkChangeOf: anAnnouncer) isTerminated not].
					true])
		do: [:anAnnouncement | wasFreeWhileDelivering := (self forkChangeOf: anAnnouncer) isTerminated]
		for: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: theStatesWhileMatching asArray equals: #(true).
	self assert: wasFreeWhileDelivering.
	self assert: anAnnouncer numberOfSubscriptions equals: 3.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> mixedRegistryIsNotLeakProne [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix not.
	self assert: (anAnnouncer subscriptions allStrongSubscriptions
				collect: [:each | each subscriber])
		equals: (Array with: aStrongSubscriber).
	self assert: (anAnnouncer subscriptions allWeakSubscriptions
				collect: [:each | each subscriber])
		equals: (Array with: aWeakSubscriber).
	self assert: anAnnouncer subscriptions allWeakSubscriptions first
				isWeakSubscription.
	self
		assert: anAnnouncer subscriptions allStrongSubscriptions first
				isWeakSubscription not.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> mixedRegistryKeepsMovedWeakSubscriptions [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	anAnnouncer useMixedSubscriptionRegistry.
	self assert: anAnnouncer subscriptions allWeakSubscriptions
		equals: (Array with: aSubscription).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> modelAndElementWithStrongSubscriptionOn: anAnnouncer extraWeakSubscriber: anExtraSubscriber [
	| aModel anElement |
	aModel := (self newSubscriber)
				heldObject: anAnnouncer;
				yourself.
	anElement := (self newSubscriber)
				heldObject: aModel;
				yourself.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anExtraSubscriber.
	^WeakArray with: anElement with: aModel
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> modelAndElementWithStrongSubscriptionOn: anAnnouncer unsubscribedWeakSubscriber: anExtraSubscriber [
	| theSurvivors |
	theSurvivors := self modelAndElementWithStrongSubscriptionOn: anAnnouncer
				extraWeakSubscriber: anExtraSubscriber.
	anAnnouncer unsubscribe: anExtraSubscriber.
	^theSurvivors
]

{ #category : #'examples - mourning' }
GtMixedSubscriptionRegistryExamples >> mournOfTheCurrentEphemeronRemovesTheEntry [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	(anAnnouncer weak)
		when: JobStart send: #onAnnouncement: to: aSubscriber;
		when: JobEnd send: #onAnnouncement: to: aSubscriber.
	(anAnnouncer subscriptions ephemeronOf: aSubscriber) mourn.
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: (anAnnouncer subscriptions ephemeronOf: aSubscriber) isNil.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> mourningTheLastWeakSubscriberReleasesTheWeakPart [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	self
		assert: (self garbageCollectUntil: 
					[anAnnouncer subscriptions isEmpty and: [(theSurvivors at: 1) isNil]]).
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	^anAnnouncer
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> newAnnouncer [
	^Announcer new useMixedSubscriptionRegistry
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> newSubscriber [
	^GtMixedSubscriptionRegistryExampleSubscriber new
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> otherRegistriesKeepWeakSubscriptionBuilder [
	<gtExample>
	self assert: Announcer new weak class equals: WeakSubscriptionBuilder.
	self assert: SystemAnnouncer uniqueInstance weak class
		equals: WeakSubscriptionBuilder.
	^Announcer new weak
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> ownedStrongSubscriberLivesAsLongAsItsOwner [
	<gtExample>
	| aWidget theSurvivors |
	aWidget := self newSubscriber.
	theSurvivors := self pageWithStrongHistoryAndWeakWidget: aWidget.
	self garbageCollect.
	self assert: (theSurvivors at: 1) notNil.
	self assert: (theSurvivors at: 2) notNil.
	(theSurvivors at: 1) heldObject first announce: JobStart new.
	self assert: (theSurvivors at: 2) announcements size equals: 1.
	self assert: aWidget announcements size equals: 1.
	aWidget := nil.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	^theSurvivors
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> pageWithStrongHistoryAndWeakWidget: aWidget [
	| anAnnouncer aHistory aPage |
	anAnnouncer := self newAnnouncer.
	aHistory := self newSubscriber.
	aPage := (self newSubscriber)
				heldObject: (Array with: anAnnouncer with: aHistory);
				yourself.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aHistory.
	aWidget heldObject: aPage.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWidget.
	^WeakArray with: aPage with: aHistory
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> pauseBetweenRounds: shouldPause [
	shouldPause
		ifTrue: [(Delay forMilliseconds: 1) wait]
		ifFalse: [Processor yield]
]

{ #category : #'examples - mourning' }
GtMixedSubscriptionRegistryExamples >> pendingMournKeepsLaterSubscriptions [
	<gtExample>
	| anAnnouncer aSubscriber aReplacedEphemeron |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aReplacedEphemeron := anAnnouncer subscriptions ephemeronOf: aSubscriber.
	anAnnouncer weak when: JobEnd send: #onAnnouncement: to: aSubscriber.
	self assert: (anAnnouncer subscriptions ephemeronOf: aSubscriber)
				~~ aReplacedEphemeron.
	aReplacedEphemeron mourn.
	self assert: anAnnouncer numberOfSubscriptions equals: 2.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer
		announce: JobStart new;
		announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 2.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerMakeStrongOfWeakSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := Announcer new.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	aSubscription makeStrong.
	self assert: aSubscription class equals: AnnouncementSubscription.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerMakeWeakBuildsWeakAnnouncementSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aWeakSubscription |
	anAnnouncer := Announcer new.
	aSubscriber := self newSubscriber.
	aWeakSubscription := (anAnnouncer
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber) makeWeak.
	self assert: aWeakSubscription class equals: WeakAnnouncementSubscription.
	self assert: aWeakSubscription action class equals: WeakMessageSend.
	self assert: aWeakSubscription subscriber == aSubscriber.
	self assert: aWeakSubscription announcer == anAnnouncer.
	self assert: aWeakSubscription announcementClass equals: JobStart.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	self assert: (anAnnouncer subscriptions subscriptions
				includes: aWeakSubscription).
	self assert: (self hasFinalizationRegistryEntryFor: aSubscriber).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerMakeWeakRejectsBlockActions [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription anErrorText |
	anAnnouncer := Announcer new.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer
				when: JobStart
				do: [:anAnnouncement | aSubscriber onAnnouncement: anAnnouncement]
				for: aSubscriber.
	anErrorText := 
			[aSubscription makeWeak.
			nil] on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'Not currently available due to missing ephemerons support'.
	self
		assert: (anAnnouncer subscriptions subscriptions includes: aSubscription).
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerStrongSubscriberIsKeptAlive [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := Announcer new.
	theSurvivors := self subscribeStrongSubscriberTo: anAnnouncer.
	self garbageCollect.
	self assert: (theSurvivors at: 1) notNil.
	anAnnouncer announce: JobStart new.
	self assert: (theSurvivors at: 1) announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerWeakSubscriberIsGarbageCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := Announcer new.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer numberOfSubscriptions = 0]).
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> plainAnnouncerWeakSubscriptionIsWeakAnnouncementSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := Announcer new.
	aSubscriber := self newSubscriber.
	self assert: anAnnouncer weak class equals: WeakSubscriptionBuilder.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self assert: aSubscription class equals: WeakAnnouncementSubscription.
	self assert: aSubscription action class equals: WeakMessageSend.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: (self hasFinalizationRegistryEntryFor: aSubscriber).
	anAnnouncer announce: JobStart new.
	anAnnouncer announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - plain registries' }
GtMixedSubscriptionRegistryExamples >> plainRegistryClassifiesStrongAndWeakSubscriptions [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber |
	anAnnouncer := Announcer new.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix not.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix.
	self assert: (anAnnouncer subscriptions allStrongSubscriptions
				collect: [:each | each subscriber])
		equals: (Array with: aStrongSubscriber).
	self assert: (anAnnouncer subscriptions allWeakSubscriptions
				collect: [:each | each subscriber])
		equals: (Array with: aWeakSubscriber).
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> plainRegistryConvertsMovedWeakSubscriptions [
	<gtExample>
	| anAnnouncer aWeakSubscriber aBlockSubscriber aStrongSubscriber aWeakSubscription aBlockSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aWeakSubscriber := self newSubscriber.
	aBlockSubscriber := self newSubscriber.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aWeakSubscriber.
	aBlockSubscription := aBlockSubscriber subscribeWithBlockTo: anAnnouncer.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer useSubscriptionRegistry: SubscriptionRegistry new.
	self assert: anAnnouncer subscriptions class equals: SubscriptionRegistry.
	self assert: anAnnouncer numberOfSubscriptions equals: 3.
	self assert: aWeakSubscription class equals: WeakAnnouncementSubscription.
	self assert: aWeakSubscription action class equals: WeakMessageSend.
	self assert: aWeakSubscription subscriber == aWeakSubscriber.
	self assert: aBlockSubscription class equals: AnnouncementSubscription.
	self assert: aBlockSubscription subscriber == aBlockSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aWeakSubscriber announcements size equals: 1.
	self assert: aBlockSubscriber announcements size equals: 1.
	self assert: aStrongSubscriber announcements size equals: 1.
	anAnnouncer removeSubscription: aWeakSubscription.
	anAnnouncer removeSubscription: aBlockSubscription.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> queryingSubscribersByClass [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self
		assert: (anAnnouncer
				subscriptionsForClass: GtMixedSubscriptionRegistryExampleSubscriber) size
		equals: 2.
	self
		assert: ((anAnnouncer
				subscriptionsForClass: GtMixedSubscriptionRegistryExampleSubscriber)
					includes: aWeakSubscriber).
	self
		assert: (anAnnouncer subscriptions
				getInteractionsForClass: GtMixedSubscriptionRegistryExampleSubscriber) size
		equals: 2.
	self assert: (anAnnouncer
				handleSubscriberClass: GtMixedSubscriptionRegistryExampleSubscriber).
	self assert: (anAnnouncer handleSubscriberClass: String) not.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> queryingSubscriptionsByAnnouncement [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	self assert: (anAnnouncer handleEventClass: JobStart).
	self assert: (anAnnouncer handleEventClass: JobEnd) not.
	self
		assert: (anAnnouncer subscriptions subscriptionsHandling: JobStart new)
				size
		equals: 2.
	self assert: (anAnnouncer subscriptions subscriptionsHandling: JobEnd new)
				isEmpty.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> queryingSubscriptionsOfASubscriber [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber theFound |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aWeakSubscriber.
	theFound := OrderedCollection new.
	anAnnouncer subscriptions subscriptionsOf: aWeakSubscriber
		do: [:each | theFound add: each].
	self assert: theFound size equals: 1.
	self assert: theFound first subscriber == aWeakSubscriber.
	self assert: (anAnnouncer hasSubscriber: aWeakSubscriber).
	self assert: (anAnnouncer hasSubscriber: aStrongSubscriber).
	self assert: (anAnnouncer hasSubscriber: self newSubscriber) not.
	self assert: (anAnnouncer subscriptions weakSubscribersWithSubscriptions
				collect: [:each | each key])
		equals: (Array with: aWeakSubscriber).
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> randomChangesKeepTheWeakPartConsistent [
	<gtExample>
	| anAnnouncer aRegistry aRandom theSubscribers theExpected theSubscriptions |
	anAnnouncer := self newAnnouncer.
	aRegistry := anAnnouncer subscriptions.
	aRandom := Random seed: 42.
	theSubscribers := (1 to: 6) collect: [:each | self newSubscriber].
	theExpected := IdentityDictionary new.
	theSubscriptions := OrderedCollection new.
	2000 timesRepeat: 
			[| aSubscriber anOperation |
			aSubscriber := theSubscribers atRandom: aRandom.
			anOperation := (1 to: 5) atRandom: aRandom.
			anOperation = 1
				ifTrue: 
					[theSubscriptions
						add: (anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber).
					theExpected at: aSubscriber
						put: (theExpected at: aSubscriber ifAbsent: [0]) + 1].
			anOperation = 2
				ifTrue: 
					[anAnnouncer unsubscribe: aSubscriber.
					theSubscriptions
						removeAllSuchThat: [:each | each subscriber == aSubscriber].
					theExpected removeKey: aSubscriber ifAbsent: []].
			(anOperation = 3 and: [theSubscriptions notEmpty])
				ifTrue: 
					[| aSubscription |
					aSubscription := theSubscriptions
								removeAt: ((1 to: theSubscriptions size) atRandom: aRandom).
					anAnnouncer removeSubscription: aSubscription.
					self decrease: aSubscription subscriber in: theExpected].
			(anOperation = 4 and: [theSubscriptions notEmpty])
				ifTrue: 
					[| aSubscription |
					aSubscription := theSubscriptions
								removeAt: ((1 to: theSubscriptions size) atRandom: aRandom).
					self decrease: aSubscription subscriber in: theExpected.
					aSubscription makeStrong.
					anAnnouncer removeSubscription: aSubscription].
			(anOperation = 5 and: [theSubscriptions notEmpty])
				ifTrue: 
					[| aSubscription |
					aSubscription := theSubscriptions atRandom: aRandom.
					self decrease: aSubscription subscriber in: theExpected.
					aSubscription subscriber: aSubscriber.
					theExpected at: aSubscriber
						put: (theExpected at: aSubscriber ifAbsent: [0]) + 1].
			self assertWeakPartInvariantOf: aRegistry.
			self assert: aRegistry numberOfWeakSubscribers equals: theExpected size.
			self assert: aRegistry numberOfSubscriptions equals: theSubscriptions size.
			theSubscribers do: 
					[:each |
					self
						assert: (aRegistry weakPart subscriptionsOf: each ifAbsent: [#()]) size
						equals: (theExpected at: each ifAbsent: [0])]].
	theSubscribers do: [:each | anAnnouncer unsubscribe: each].
	self assert: (self hasNoWeakPart: aRegistry).
	self assert: aRegistry isEmpty.
	^anAnnouncer
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> readerOf: theAnnouncers until: aDeadline [
	^
	[[Time millisecondClockValue < aDeadline] whileTrue: 
			[theAnnouncers do: 
					[:anAnnouncer |
					| aRegistry |
					aRegistry := anAnnouncer subscriptions.
					aRegistry numberOfSubscriptions.
					aRegistry numberOfWeakSubscribers.
					aRegistry isEmpty.
					aRegistry weakPart isEmpty.
					aRegistry subscriptions do: [:each | each subscriber].
					aRegistry weakSubscribersWithSubscriptions.
					self assertWeakPartInvariantOf: aRegistry].
			(Delay forMilliseconds: 1) wait]]
]

{ #category : #'examples - concurrency' }
GtMixedSubscriptionRegistryExamples >> releasingTheWeakPartWaitsForTheLock [
	<gtExample>
	| anAnnouncer aSubscriber aRegistry aWorker isFinished |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aRegistry := anAnnouncer subscriptions.
	isFinished := Semaphore new.
	aRegistry protected: 
			[aWorker := 
					[anAnnouncer unsubscribe: aSubscriber.
					isFinished signal]
							forkAt: Processor activePriority + 1.
			self assert: aWorker isTerminated not.
			self assert: (self hasOwnWeakPart: aRegistry).
			self assert: (aRegistry hasSubscriber: aSubscriber)].
	self assert: (isFinished waitTimeoutMilliseconds: 5000) not.
	self assert: (self hasNoWeakPart: aRegistry).
	self assert: aRegistry isEmpty.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> removeStrongSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self
		assert: (anAnnouncer removeSubscription: aSubscription) == aSubscription.
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: (anAnnouncer removeSubscription: aSubscription) isNil.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> removeWeakSubscription [
	<gtExample>
	| anAnnouncer aSubscriber aFirstSubscription aSecondSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aFirstSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	aSecondSubscription := anAnnouncer weak
				when: JobEnd
				send: #onAnnouncement:
				to: aSubscriber.
	self assert: (anAnnouncer removeSubscription: aFirstSubscription)
				== aFirstSubscription.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	self assert: (anAnnouncer removeSubscription: aFirstSubscription) isNil.
	anAnnouncer removeSubscription: aSecondSubscription.
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 0.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> removingTheLastWeakSubscriptionReleasesTheWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription anotherSubscription |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	anotherSubscription := anAnnouncer weak
				when: JobEnd
				send: #onAnnouncement:
				to: aSubscriber.
	anAnnouncer removeSubscription: aSubscription.
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	anAnnouncer removeSubscription: anotherSubscription.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> replaceMissingSubscriptionSignalsNotFound [
	<gtExample>
	| aRegistry aSubscription anError |
	aRegistry := self emptyRegistry.
	aSubscription := (AnnouncementSubscription new)
				announcementClass: JobStart;
				subscriber: self newSubscriber;
				yourself.
	anError := 
			[aRegistry replace: aSubscription with: aSubscription copy.
			nil]
					on: NotFound
					do: [:anException | anException].
	self assert: anError notNil.
	self assert: anError object == aSubscription.
	self assert: aRegistry isEmpty.
	^anError
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> runWorkers: thePrioritizedWorkers until: aDeadline [
	| aLock theErrors theFinished theWorkers haveFinished theProcesses aWaitDeadline |
	aLock := Mutex new.
	theErrors := OrderedCollection new.
	theFinished := Semaphore new.
	theWorkers := thePrioritizedWorkers asArray.
	haveFinished := Array new: theWorkers size withAll: false.
	theProcesses := theWorkers withIndexCollect: 
					[:aPrioritizedWorker :anIndex |
					(
					[
					[[aPrioritizedWorker value value] on: Error
						do: [:anError | aLock critical: [theErrors add: anError]]]
							ensure: 
								[haveFinished at: anIndex put: true.
								theFinished signal]]
							newProcess)
						priority: aPrioritizedWorker key;
						name: 'GtMixedSubscriptionRegistryExamples worker';
						yourself].
	self startAll: theProcesses.
	aWaitDeadline := aDeadline + 20000.
	theProcesses size timesRepeat: 
			[theFinished
				waitTimeoutMilliseconds: (aWaitDeadline - Time millisecondClockValue max: 1)].
	theProcesses withIndexDo: 
			[:each :anIndex |
			(haveFinished at: anIndex)
				ifFalse: 
					[aLock critical: 
							[theErrors add: 'A worker did not finish: ' , each priority printString].
					each terminate]].
	^theErrors
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> sameSubscriberWithStrongAndWeakSubscriptionsIsCollected [
	<gtExample>
	| theSurvivors |
	theSurvivors := self
				subscriberHoldingAnnouncerWithStrongAndWeakSubscriptions.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	^theSurvivors
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> scavengerUntil: aDeadline [
	^
	[[Time millisecondClockValue < aDeadline] whileTrue: 
			[Smalltalk garbageCollectMost.
			(Delay forMilliseconds: 5) wait]]
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> staleMournAfterTheWeakPartWasReleasedKeepsTheNewEntry [
	<gtExample>
	| anAnnouncer aSubscriber aStaleEphemeron |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aStaleEphemeron := anAnnouncer subscriptions ephemeronOf: aSubscriber.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aStaleEphemeron mourn.
	self assert: (anAnnouncer hasSubscriber: aSubscriber).
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - mourning' }
GtMixedSubscriptionRegistryExamples >> staleMournKeepsTheEntryOfAResubscription [
	<gtExample>
	| anAnnouncer aSubscriber aStaleEphemeron |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	aStaleEphemeron := anAnnouncer subscriptions ephemeronOf: aSubscriber.
	anAnnouncer unsubscribe: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (anAnnouncer subscriptions ephemeronOf: aSubscriber)
				~~ aStaleEphemeron.
	aStaleEphemeron mourn.
	self assert: (anAnnouncer hasSubscriber: aSubscriber).
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> startAll: theProcesses [
	| aRunner aRunnerPriority |
	aRunner := Processor activeProcess.
	aRunnerPriority := aRunner priority.
	aRunner
		priority: ((theProcesses inject: 0
				into: [:aMaximum :each | aMaximum max: each priority]) + 1
				max: aRunnerPriority).
	[theProcesses do: [:each | each resume]]
		ensure: [aRunner priority: aRunnerPriority]
]

{ #category : #'private - concurrency' }
GtMixedSubscriptionRegistryExamples >> stateOf: aRegistry [
	^Array
		with: aRegistry numberOfSubscriptions
		with: aRegistry numberOfWeakSubscribers
		with: aRegistry weakPart
		with: (aRegistry subscriptions
				collect: [:each | each identityHash -> each subscriber identityHash])
					asSortedCollection asArray
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> strongAndWeakSubscriptionsOfOneSubscriber [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: anAnnouncer numberOfSubscriptions equals: 2.
	self assert: anAnnouncer subscriptions allStrongSubscriptions size
		equals: 1.
	self assert: anAnnouncer subscriptions allWeakSubscriptions size equals: 1.
	self assert: (anAnnouncer hasSubscriber: aSubscriber).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 2.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> strongSubscriberIsKeptAliveByTheAnnouncer [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeStrongSubscriberTo: anAnnouncer.
	self garbageCollect.
	self assert: (theSurvivors at: 1) notNil.
	anAnnouncer announce: JobStart new.
	self assert: (theSurvivors at: 1) announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> strongSubscriptionDelivers [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self assert: aSubscription class equals: AnnouncementSubscription.
	self assert: anAnnouncer subscriptions allStrongSubscriptions
		equals: (Array with: aSubscription).
	self assert: anAnnouncer subscriptions allWeakSubscriptions isEmpty.
	anAnnouncer announce: JobStart new.
	anAnnouncer announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 1.
	self assert: aSubscriber announcements first class equals: JobStart.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> strongSubscriptionsKeepTheSharedWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeOneWeakSubscriberToAll: theAnnouncers [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	theAnnouncers
		do: [:each | each weak when: JobStart send: #onAnnouncement: to: aSubscriber].
	self assert: (theAnnouncers
				allSatisfy: [:each | each subscriptions numberOfWeakSubscribers = 1]).
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeStrongSubscriberTo: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeStrongThenMakeWeakTo: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	(anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber)
		makeWeak.
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeTenuredWeakSubscriberTo: anAnnouncer [
	| aSubscriber |
	aSubscriber := GtMixedSubscriptionRegistryExampleSubscriber
				basicNewTenured initialize.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeWeakBlockSubscriberTo: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	aSubscriber subscribeWithBlockTo: anAnnouncer.
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscribeWeakSubscriberTo: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	^WeakArray with: aSubscriber
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscriberHoldingAnnouncerWithStrongAndWeakSubscriptions [
	| anAnnouncer aSubscriber |
	anAnnouncer := self newAnnouncer.
	aSubscriber := (self newSubscriber)
				heldObject: anAnnouncer;
				yourself.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	^WeakArray with: aSubscriber
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> subscriberHoldingItsOwnWeakSubscriptionIsCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self
				subscriberHoldingItsOwnWeakSubscriptionOn: anAnnouncer.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> subscriberHoldingItsOwnWeakSubscriptionOn: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	aSubscriber heldObject: (anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber).
	^WeakArray with: aSubscriber
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> subscriptionOfAnyClassGoesToStrongPart [
	<gtExample>
	| aRegistry aSubscriptionLikeObject |
	aRegistry := self emptyRegistry.
	aSubscriptionLikeObject := Object new.
	self
		assert: (aRegistry add: aSubscriptionLikeObject) == aSubscriptionLikeObject.
	self assert: aRegistry allStrongSubscriptions
		equals: (Array with: aSubscriptionLikeObject).
	self assert: aRegistry numberOfWeakSubscribers equals: 0.
	self assert: (aRegistry remove: aSubscriptionLikeObject)
				== aSubscriptionLikeObject.
	self assert: aRegistry isEmpty.
	^aRegistry
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> tenuredWeakSubscriberNeedsFullGarbageCollection [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeTenuredWeakSubscriberTo: anAnnouncer.
	2 timesRepeat: [Smalltalk garbageCollectMost].
	self assert: (theSurvivors at: 1) notNil.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 0.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> unsubscribeDuringDelivery [
	<gtExample>
	| anAnnouncer aLeavingSubscriber aStayingSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aLeavingSubscriber := self newSubscriber.
	aStayingSubscriber := self newSubscriber.
	anAnnouncer weak
		when: JobStart
		do: 
			[:anAnnouncement |
			aLeavingSubscriber onAnnouncement: anAnnouncement.
			anAnnouncer unsubscribe: aLeavingSubscriber]
		for: aLeavingSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStayingSubscriber.
	anAnnouncer announce: JobStart new.
	anAnnouncer announce: JobStart new.
	self assert: aLeavingSubscriber announcements size equals: 1.
	self assert: aStayingSubscriber announcements size equals: 2.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> unsubscribeRemovesStrongAndWeakSubscriptions [
	<gtExample>
	| anAnnouncer aSubscriber anotherSubscriber theRemoved |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anotherSubscriber.
	theRemoved := anAnnouncer subscriptions removeSubscriber: aSubscriber.
	self assert: theRemoved size equals: 2.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	self assert: (anAnnouncer hasSubscriber: aSubscriber) not.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer unsubscribe: anotherSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 0.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements isEmpty.
	self assert: anotherSubscriber announcements isEmpty.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> unsubscribedWeakSubscriberDoesNotKeepElementAlive [
	<gtExample>
	| anExtraSubscriber theSurvivors |
	anExtraSubscriber := self newSubscriber.
	theSurvivors := self
				modelAndElementWithStrongSubscriptionOn: self newAnnouncer
				unsubscribedWeakSubscriber: anExtraSubscriber.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	self assert: (self hasFinalizationRegistryEntryFor: anExtraSubscriber) not.
	^theSurvivors
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> unsubscribingTheLastWeakSubscriberReleasesTheWeakPart [
	<gtExample>
	| anAnnouncer aSubscriber anotherSubscriber |
	anAnnouncer := self newAnnouncer.
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anotherSubscriber.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	anAnnouncer unsubscribe: anotherSubscriber.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (self hasOwnWeakPart: anAnnouncer subscriptions).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	self assert: anotherSubscriber announcements isEmpty.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> useMixedRegistryKeepsExistingSubscriptions [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aLegacySubscription |
	anAnnouncer := Announcer new.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	aLegacySubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aWeakSubscriber.
	anAnnouncer useMixedSubscriptionRegistry.
	self assert: anAnnouncer subscriptions class
		equals: GtMixedSubscriptionRegistry.
	self assert: anAnnouncer numberOfSubscriptions equals: 2.
	self assert: anAnnouncer subscriptions allWeakSubscriptions
		equals: (Array with: aLegacySubscription).
	self assert: aLegacySubscription class equals: WeakAnnouncementSubscription.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix.
	anAnnouncer announce: JobStart new.
	self assert: aStrongSubscriber announcements size equals: 1.
	self assert: aWeakSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> valuableThatIsItsOwnSubscriberCannotBeSubscribedWeakly [
	<gtExample>
	| anAnnouncer aBlock anErrorText |
	anAnnouncer := self announcerWithMixedRegistry.
	aBlock := [:anAnnouncement | anAnnouncement].
	anErrorText := 
			[anAnnouncer weak when: JobStart do: aBlock for: aBlock.
			nil] on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'A valuable that is its own subscriber cannot be subscribed weakly'.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #private }
GtMixedSubscriptionRegistryExamples >> waitUntil: aBlock [
	| aDeadline |
	aDeadline := Time millisecondClockValue + 10000.
	[aBlock value] whileFalse: 
			[Time millisecondClockValue > aDeadline ifTrue: [^false].
			(Delay forMilliseconds: 10) wait].
	^true
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> weakAnnouncementSubscriptionInMixedRegistryIsClassifiedAsWeak [
	<gtExample>
	| anAnnouncer aStrongSubscriber aWeakSubscriber aLegacySubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aStrongSubscriber := self newSubscriber.
	aWeakSubscriber := self newSubscriber.
	anAnnouncer when: JobStart send: #onAnnouncement: to: aStrongSubscriber.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix not.
	aLegacySubscription := (WeakSubscriptionBuilder on: anAnnouncer)
				when: JobStart
				send: #onAnnouncement:
				to: aWeakSubscriber.
	self assert: aLegacySubscription class equals: WeakAnnouncementSubscription.
	self assert: anAnnouncer subscriptions allWeakSubscriptions
		equals: (Array with: aLegacySubscription).
	self assert: (anAnnouncer subscriptions allStrongSubscriptions
				collect: [:each | each subscriber])
		equals: (Array with: aStrongSubscriber).
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix.
	anAnnouncer announce: JobStart new.
	self assert: aWeakSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> weakBlockSubscriberIsGarbageCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakBlockSubscriberTo: anAnnouncer.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakBlockSubscriptionUsesTheGivenSubscriber [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := aSubscriber subscribeWithBlockTo: anAnnouncer.
	self assert: aSubscription class
		equals: GtEphemeronAnnouncementSubscription.
	self assert: aSubscription subscriber == aSubscriber.
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> weakBlocksCanTakeNoArgumentOrTheAnnouncerAsSecondArgument [
	<gtExample>
	| anAnnouncer aSubscriber wasCalled theReceivedAnnouncement theReceivedAnnouncer anAnnouncement |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	wasCalled := false.
	anAnnouncer weak
		when: JobStart
		do: [wasCalled := true]
		for: aSubscriber.
	anAnnouncer weak
		when: JobStart
		do: 
			[:anAnnouncementArgument :anAnnouncerArgument |
			theReceivedAnnouncement := anAnnouncementArgument.
			theReceivedAnnouncer := anAnnouncerArgument]
		for: aSubscriber.
	anAnnouncement := JobStart new.
	anAnnouncer announce: anAnnouncement.
	self assert: wasCalled.
	self assert: theReceivedAnnouncement == anAnnouncement.
	self assert: theReceivedAnnouncer == anAnnouncer.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> weakBuilderKeptAcrossASwitchSubscribesInTheCurrentRegistry [
	<gtExample>
	| anAnnouncer aBuilder aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aBuilder := anAnnouncer weak.
	anAnnouncer useSubscriptionRegistry: SubscriptionRegistry new.
	aSubscriber := self newSubscriber.
	aSubscription := aBuilder
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self assert: aSubscription class equals: WeakAnnouncementSubscription.
	self
		assert: (anAnnouncer subscriptions subscriptions
				collect: [:each | each class]) asArray
		equals: (Array with: WeakAnnouncementSubscription).
	anAnnouncer announce: JobStart new.
	self assert: aSubscriber announcements size equals: 1.
	aSubscription makeStrong.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakConstantBlockSubscriptionUsesTheGivenSubscriber [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				do: [:anAnnouncement | nil]
				for: aSubscriber.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobStart new.
	anAnnouncer unsubscribe: aSubscriber.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'examples - lazy weak part' }
GtMixedSubscriptionRegistryExamples >> weakPartKeepsTheCurrentEphemeronOfASubscriber [
	<gtExample>
	| aSubscriber anotherSubscriber aStaleEphemeron aCurrentEphemeron anotherEphemeron aPart |
	aSubscriber := self newSubscriber.
	anotherSubscriber := self newSubscriber.
	aStaleEphemeron := WeakKeyAssociation key: aSubscriber
				value: (IdentitySet with: #first).
	aCurrentEphemeron := WeakKeyAssociation key: aSubscriber
				value: (IdentitySet with: #first with: #second).
	anotherEphemeron := WeakKeyAssociation key: anotherSubscriber
				value: (IdentitySet with: #third).
	aPart := (GtNoWeakSubscriptions uniqueInstance
				withEphemeron: aStaleEphemeron) withEphemeron: anotherEphemeron.
	self assert: (aPart withEphemeron: aCurrentEphemeron) == aPart.
	self assert: aPart numberOfSubscribers equals: 2.
	self assert: aPart numberOfSubscriptions equals: 3.
	self assert: (aPart ephemeronOf: aSubscriber) == aCurrentEphemeron.
	self assert: (aPart withoutEphemeron: aStaleEphemeron) == aPart.
	self assert: (aPart ephemeronOf: aSubscriber) == aCurrentEphemeron.
	self assert: (aPart withoutEphemeron: aCurrentEphemeron) == aPart.
	self assert: (aPart ephemeronOf: aSubscriber) isNil.
	self assert: (aPart withoutSubscriber: aSubscriber) == aPart.
	self assert: (aPart withoutSubscriber: anotherSubscriber)
				== GtNoWeakSubscriptions uniqueInstance.
	^aPart
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> weakSubscriberCapturedByItsBlockIsCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakBlockSubscriberTo: anAnnouncer.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self waitUntil: [anAnnouncer subscriptions isEmpty]).
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> weakSubscriberIsGarbageCollected [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: anAnnouncer subscriptions isEmpty.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 0.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> weakSubscriberIsMournedByAScavengeDuringDelivery [
	<gtExample>
	| anAnnouncer aTrigger theSurvivors |
	anAnnouncer := self newAnnouncer.
	aTrigger := self newSubscriber.
	anAnnouncer
		when: JobStart
		do: [:anAnnouncement | Smalltalk garbageCollectMost]
		for: aTrigger.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	anAnnouncer announce: JobStart new.
	self assert: (self
				waitUntil: [anAnnouncer subscriptions numberOfWeakSubscribers = 0]).
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> weakSubscriberOfTwoAnnouncersIsCollectedFromBoth [
	<gtExample>
	| theAnnouncers theSurvivors |
	theAnnouncers := Array with: self newAnnouncer with: self newAnnouncer.
	theSurvivors := self subscribeOneWeakSubscriberToAll: theAnnouncers.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil
						and: [theAnnouncers allSatisfy: [:each | each numberOfSubscriptions = 0]]]).
	theAnnouncers
		do: [:each | self assert: (self hasNoWeakPart: each subscriptions)].
	^theAnnouncers
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionDelivers [
	<gtExample>
	| anAnnouncer aSubscriber aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	aSubscription := anAnnouncer weak
				when: JobStart
				send: #onAnnouncement:
				to: aSubscriber.
	self assert: aSubscription class
		equals: GtEphemeronAnnouncementSubscription.
	self assert: aSubscription subscriber == aSubscriber.
	self assert: aSubscription action class equals: WeakMessageSend.
	self assert: aSubscription announcer == anAnnouncer.
	self assert: anAnnouncer subscriptions allStrongSubscriptions isEmpty.
	self assert: anAnnouncer subscriptions allWeakSubscriptions
		equals: (Array with: aSubscription).
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobStart new.
	anAnnouncer announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionHasNoFinalizationRegistryEntry [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber.
	self assert: (self hasFinalizationRegistryEntryFor: aSubscriber) not.
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionHeldBy: aHolder on: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	aHolder
		add: (anAnnouncer weak when: JobStart send: #onAnnouncement: to: aSubscriber).
	^WeakArray with: aSubscriber
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionNeedsASubscriber [
	<gtExample>
	| anAnnouncer anErrorText |
	anAnnouncer := self announcerWithMixedRegistry.
	anErrorText := 
			[anAnnouncer weak when: JobStart send: #yourself to: nil.
			nil] on: Error
					do: [:anError | anError messageText].
	self assert: anErrorText
		equals: 'A weak subscription needs a subscriber that can be garbage collected'.
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionOfDyingSubscriberOn: anAnnouncer [
	^anAnnouncer weak
		when: JobStart
		send: #onAnnouncement:
		to: self newSubscriber
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionToASetWithAnExclusion [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak
		when: (JobStart , JobEnd , JobChange) - JobEnd
		send: #onAnnouncement:
		to: aSubscriber.
	anAnnouncer announce: JobStart new.
	anAnnouncer announce: JobEnd new.
	anAnnouncer announce: JobChange new.
	anAnnouncer announce: Announcement new.
	self
		assert: (aSubscriber announcements collect: [:each | each class]) asArray
		equals: (Array with: JobStart with: JobChange).
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionToASymbol [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	anAnnouncer weak when: #ping send: #onAnnouncement: to: aSubscriber.
	anAnnouncer announce: #ping.
	anAnnouncer announce: #pong.
	self assert: aSubscriber announcements asArray equals: #(#ping).
	^anAnnouncer
]

{ #category : #'private - scenarios' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionWithBlockActionHeldBy: aHolder on: anAnnouncer [
	| aSubscriber |
	aSubscriber := self newSubscriber.
	aHolder add: (anAnnouncer weak
				when: JobStart
				do: [:anAnnouncement | aSubscriber onAnnouncement: anAnnouncement]
				for: aSubscriber).
	^WeakArray with: aSubscriber
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionWithoutSubscriberIsNotKept [
	<gtExample>
	| anAnnouncer aSubscription |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscription := (GtEphemeronAnnouncementSubscription new)
				announcer: anAnnouncer;
				announcementClass: JobStart;
				action: [:anAnnouncement | ];
				yourself.
	self assert: aSubscription subscriber isNil.
	anAnnouncer basicSubscribe: aSubscription.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	self assert: (self hasNoWeakPart: anAnnouncer subscriptions).
	^anAnnouncer
]

{ #category : #'examples - basic' }
GtMixedSubscriptionRegistryExamples >> weakSubscriptionsOfOneSubscriberShareOneEphemeron [
	<gtExample>
	| anAnnouncer aSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	aSubscriber := self newSubscriber.
	(anAnnouncer weak)
		when: JobStart send: #onAnnouncement: to: aSubscriber;
		when: JobEnd send: #onAnnouncement: to: aSubscriber;
		when: JobStart , JobEnd
			send: #onAnnouncement:
			to: aSubscriber.
	self assert: anAnnouncer numberOfSubscriptions equals: 3.
	self assert: anAnnouncer subscriptions numberOfWeakSubscribers equals: 1.
	anAnnouncer announce: JobEnd new.
	self assert: aSubscriber announcements size equals: 2.
	^anAnnouncer
]

{ #category : #'examples - compatibility' }
GtMixedSubscriptionRegistryExamples >> whereConditionThatSubscribesDoesNotHideOtherSubscribers [
	<gtExample>
	| anAnnouncer theSubscribers aLateSubscriber |
	anAnnouncer := self announcerWithMixedRegistry.
	theSubscribers := (1 to: 20) collect: [:each | self newSubscriber].
	theSubscribers
		do: [:each | anAnnouncer weak when: JobStart send: #onAnnouncement: to: each].
	aLateSubscriber := self newSubscriber.
	anAnnouncer weak
		when: (JobStart where: 
					[:anAnnouncement |
					1 to: 50
						do: 
							[:each |
							anAnnouncer weak
								when: JobEnd
								send: #onAnnouncement:
								to: self newSubscriber].
					true])
		send: #onAnnouncement:
		to: aLateSubscriber.
	anAnnouncer announce: JobStart new.
	self
		assert: (theSubscribers allSatisfy: [:each | each announcements size = 1]).
	self assert: aLateSubscriber announcements size equals: 1.
	^anAnnouncer
]

{ #category : #'examples - garbage collection' }
GtMixedSubscriptionRegistryExamples >> youngWeakSubscriberIsMournedByScavenges [
	<gtExample>
	| anAnnouncer theSurvivors |
	anAnnouncer := self newAnnouncer.
	theSurvivors := self subscribeWeakSubscriberTo: anAnnouncer.
	2 timesRepeat: [Smalltalk garbageCollectMost].
	self assert: (self
				waitUntil: [anAnnouncer subscriptions numberOfWeakSubscribers = 0]).
	self assert: anAnnouncer subscriptions isEmpty.
	^anAnnouncer
]
