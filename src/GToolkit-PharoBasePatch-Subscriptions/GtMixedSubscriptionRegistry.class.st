"
I am a subscription registry for an {{gtClass:Announcer}} that keeps strong and weak subscriptions apart. Install me with {{gtMethod:Announcer>>#useMixedSubscriptionRegistry}}.

Strong subscriptions are held in a set, as in {{gtClass:SubscriptionRegistry}}: the announcer keeps their subscribers alive.

Weak subscriptions are {{gtClass:GtEphemeronAnnouncementSubscription}}s, created by {{gtMethod:Announcer>>#weak}} and {{gtMethod:AnnouncementSubscription>>#makeWeak}}. Like a {{gtClass:WeakAnnouncementSubscription}} they reference their subscriber only weakly. I group them by subscriber and hold each group through one ephemeron (a {{gtClass:WeakKeyAssociation}} keyed on the subscriber) that only I reference. A weak subscription whose subscriber is already gone is not added. When the subscriber is garbage collected, the ephemeron is mourned and I remove the whole group. There is no {{gtClass:FinalizationRegistry}} entry, so a live weak subscriber cannot keep me, and through me my strong subscribers, alive, and unsubscribing leaves nothing behind. The subscriber object itself disappears one collection after its group was removed.

The container of each ephemeron is a {{gtClass:GtEphemeronSubscriptionsMourner}}, which asks me to remove exactly that ephemeron ({{gtMethod:GtMixedSubscriptionRegistry>>#removeEphemeron:}}). Every weak subscription I add installs a fresh ephemeron, so a mourn that arrives late, after the subscriber was unsubscribed and subscribed again or after it subscribed again while dying, removes nothing.

A {{gtClass:WeakAnnouncementSubscription}} added to me, with {{gtMethod:Announcer>>#basicSubscribe:}} or when an announcer switches to me with its existing subscriptions, keeps its Pharo behaviour, including its global finalization entry. I keep it next to my strong subscriptions, report it as weak, and report myself as {{gtMethod:GtMixedSubscriptionRegistry>>#hasLeakProneSubscriptionMix}} while it is there together with strong subscriptions.

{{gtMethod:GtMixedSubscriptionRegistry>>#subscriptions}} answers a copy, strong subscriptions first. Like a {{gtClass:SubscriptionRegistry}}, I match an announcement under my lock and collect only the subscriptions that handle it ({{gtMethod:GtMixedSubscriptionRegistry>>#subscriptionsHandling:}}); delivery then runs outside my lock, to strong subscriptions before weak ones. Every change runs through {{gtMethod:GtMixedSubscriptionRegistry>>#protectedChange:}}, which takes my lock and stores a new marker ({{gtMethod:GtMixedSubscriptionRegistry>>#noteChange}}). Matching code, such as a `where:` condition, can change me while I match; when the marker changed during matching, I match again on a copy of my subscriptions as they are then. My lock is a reentrant {{gtClass:Mutex}}, because clients such as {{gtClass:BlHandlerAnnouncerRegistry}} send {{gtMethod:GtMixedSubscriptionRegistry>>#subscriptions}} inside {{gtMethod:GtMixedSubscriptionRegistry>>#protected:}}.

My weak part is an object of its own. Until my first weak subscription it is the stateless {{gtClass:GtNoWeakSubscriptions}}, shared by all registries. The first weak subscription replaces it with a {{gtClass:GtWeakSubscriptions}}, which holds the ephemerons and hands the shared empty part back when its last weak subscriber goes away. Most announcers never get a weak subscriber, so they cost as much as with a {{gtClass:SubscriptionRegistry}} plus my reentrant lock.

When an announcer using me is serialized with Fuel, my weak subscriptions are left out; after materialization I have only the strong ones.

{{gtMethod:GtMixedSubscriptionRegistry>>#gtOverviewFor:}} shows how many strong, weak and old-style weak subscriptions I hold and whether I am leak-prone.
"
Class {
	#name : #GtMixedSubscriptionRegistry,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'strongSubscriptions',
		'weakSubscriptions',
		'lastChange'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Core'
}

{ #category : #serialization }
GtMixedSubscriptionRegistry class >> fuelIgnoredInstanceVariableNames [
	^#('monitor' 'weakSubscriptions' 'lastChange')
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> add: aSubscription [
	^self
		protectedChange: [aSubscription addToMixedSubscriptionRegistry: self]
]

{ #category : #'private - adding' }
GtMixedSubscriptionRegistry >> addStrongSubscription: aSubscription [
	^strongSubscriptions add: aSubscription
]

{ #category : #'private - adding' }
GtMixedSubscriptionRegistry >> addWeakSubscription: aSubscription [
	| aSubscriber theSubscriptions |
	aSubscriber := aSubscription subscriber.
	aSubscriber ifNil: [^aSubscription].
	theSubscriptions := self weakPart subscriptionsOf: aSubscriber
				ifAbsent: [IdentitySet new].
	theSubscriptions add: aSubscription.
	self installGroupOf: aSubscriber holding: theSubscriptions.
	^aSubscription
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> allStrongSubscriptions [
	^self protected: 
			[(strongSubscriptions reject: [:each | each isWeakSubscription]) asArray]
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> allWeakSubscriptions [
	^self protected: 
			[Array streamContents: 
					[:aStream |
					strongSubscriptions
						do: [:each | each isWeakSubscription ifTrue: [aStream nextPut: each]].
					self weakPart subscriptionsDo: [:each | aStream nextPut: each]]]
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> changeSubscriberOf: aSubscription to: aSubscriber [
	self protectedChange: 
			[| isRegistered |
			isRegistered := (self removeWeakSubscription: aSubscription) notNil.
			aSubscription basicSubscriber: aSubscriber.
			isRegistered ifTrue: [self addWeakSubscription: aSubscription]]
]

{ #category : #announcing }
GtMixedSubscriptionRegistry >> deliver: anAnnouncement [
	| theInterestedSubscriptions |
	self isEmpty ifTrue: [^self].
	theInterestedSubscriptions := self subscriptionsHandling: anAnnouncement.
	theInterestedSubscriptions ifEmpty: [^self].
	anAnnouncement prepareForDelivery.
	self deliver: anAnnouncement to: theInterestedSubscriptions
]

{ #category : #private }
GtMixedSubscriptionRegistry >> deliver: anAnnouncement to: theSubscriptions [
	^self deliver: anAnnouncement to: theSubscriptions startingAt: 1
]

{ #category : #private }
GtMixedSubscriptionRegistry >> deliver: anAnnouncement to: theSubscriptions startingAt: aStartIndex [
	aStartIndex
		to: theSubscriptions size
		do: [ :anIndex | 
			[ (theSubscriptions at: anIndex) deliver: anAnnouncement ]
				ifCurtailed: [ self
						deliver: anAnnouncement
						to: theSubscriptions
						startingAt: anIndex + 1 ] ]
]

{ #category : #'private - accessing' }
GtMixedSubscriptionRegistry >> ephemeronOf: aSubscriber [
	^self protected: [self weakPart ephemeronOf: aSubscriber]
]

{ #category : #serialization }
GtMixedSubscriptionRegistry >> fuelAfterMaterialization [
	monitor := Mutex new.
	self weakPart: GtNoWeakSubscriptions uniqueInstance
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> getInteractionsForClass: anEventClass [
	^(self subscriptions
		select: [:each | each subscriber class includesBehavior: anEventClass])
			collect: [:each | each subscriber]
			as: OrderedCollection
]

{ #category : #'gt - extensions' }
GtMixedSubscriptionRegistry >> gtOverviewFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Overview';
		priority: 49;
		items: [self gtOverviewRows];
		actionUpdateButtonTooltip: 'Update overview';
		column: 'Property'
			text: [:each | each first]
			width: 200;
		column: 'Value' text: [:each | each second];
		send: [:each | each last]
]

{ #category : #'gt - extensions' }
GtMixedSubscriptionRegistry >> gtOverviewRows [
	^self protected: 
			[| theStrong theOldStyleWeak theWeak |
			theStrong := (strongSubscriptions
						reject: [:each | each isWeakSubscription]) asArray.
			theOldStyleWeak := (strongSubscriptions
						select: [:each | each isWeakSubscription]) asArray.
			theWeak := Array streamContents: 
							[:aStream |
							self weakPart subscriptionsDo: [:each | aStream nextPut: each]].
			(OrderedCollection new)
				add: (Array
							with: 'Strong subscriptions'
							with: theStrong size printString
							with: theStrong);
				add: (Array
							with: 'Weak subscriptions'
							with: theWeak size printString
							with: theWeak);
				add: (Array
							with: 'Weak subscribers'
							with: self numberOfWeakSubscribers printString
							with: self weakSubscribersWithSubscriptions);
				add: (Array
							with: 'Old-style weak subscriptions'
							with: theOldStyleWeak size printString
							with: theOldStyleWeak);
				add: (Array
							with: 'Leak-prone mix'
							with: (self hasLeakProneSubscriptionMix
									ifTrue: 
										['yes: the global entries of the old-style weak subscriptions keep the strong subscribers alive']
									ifFalse: ['no'])
							with: theOldStyleWeak);
				add: (Array
							with: 'Weak part'
							with: self weakPart gtOverviewDescription
							with: self weakPart);
				yourself]
]

{ #category : #'gt - extensions' }
GtMixedSubscriptionRegistry >> gtSubscriptionsFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Subscriptions';
		priority: 50;
		items: 
				[(self allStrongSubscriptions collect: [:each | 'strong' -> each])
					, (self allWeakSubscriptions collect: [:each | 'weak' -> each])];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Part' text: [:anAssociation | anAssociation key];
		column: 'Subscriber'
			text: [:anAssociation | anAssociation value subscriber];
		column: 'Announcement'
			text: [:anAssociation | anAssociation value announcementClass];
		column: 'Kind' text: [:anAssociation | anAssociation value class];
		send: [:anAssociation | anAssociation value]
]

{ #category : #'gt - extensions' }
GtMixedSubscriptionRegistry >> gtWeakSubscribersFor: aView [
	<gtView>
	^(aView columnedList)
		title: 'Weak subscribers';
		priority: 51;
		items: [self weakSubscribersWithSubscriptions];
		actionUpdateButtonTooltip: 'Update weak subscriber list';
		column: 'Subscriber' text: [:anAssociation | anAssociation key];
		column: 'Subscriptions'
			text: [:anAssociation | anAssociation value size]
			width: 100;
		column: 'Announcements'
			text: 
				[:anAssociation |
				String streamContents: 
						[:aStream |
						anAssociation value do: [:each | aStream print: each announcementClass]
							separatedBy: [aStream nextPutAll: ', ']]];
		send: [:anAssociation | anAssociation value]
]

{ #category : #testing }
GtMixedSubscriptionRegistry >> handleEventClass: anEventClass [
	^self subscriptions
		anySatisfy: [:each | each announcementClass includesBehavior: anEventClass]
]

{ #category : #testing }
GtMixedSubscriptionRegistry >> handleSubscriberClass: aSubscriberClass [
	^self subscriptions
		anySatisfy: [:each | each subscriber class includesBehavior: aSubscriberClass]
]

{ #category : #testing }
GtMixedSubscriptionRegistry >> hasLeakProneSubscriptionMix [
	^self protected: 
			[(strongSubscriptions contains: [:each | each isWeakSubscription])
				and: [strongSubscriptions contains: [:each | each isWeakSubscription not]]]
]

{ #category : #testing }
GtMixedSubscriptionRegistry >> hasSubscriber: aSubscriber [
	self subscriptionsOf: aSubscriber do: [:each | ^true].
	^false
]

{ #category : #initialization }
GtMixedSubscriptionRegistry >> initialize [
	super initialize.
	monitor := Mutex new.
	self reset
]

{ #category : #'private - adding' }
GtMixedSubscriptionRegistry >> installGroupOf: aSubscriber holding: theSubscriptions [
	self weakPart: (self weakPart
				withEphemeron: (self newEphemeronOf: aSubscriber holding: theSubscriptions))
]

{ #category : #testing }
GtMixedSubscriptionRegistry >> isEmpty [
	^strongSubscriptions isEmpty and: [self weakPart isEmpty]
]

{ #category : #'private - accessing' }
GtMixedSubscriptionRegistry >> lastChange [
	^lastChange
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> makeStrong: anEphemeronSubscription for: aSubscriber [
	^self protectedChange: 
			[| isRegistered aStrongSubscription |
			isRegistered := (self removeWeakSubscription: anEphemeronSubscription)
						notNil.
			aStrongSubscription := (AnnouncementSubscription new)
						announcer: anEphemeronSubscription announcer;
						announcementClass: anEphemeronSubscription announcementClass;
						action: anEphemeronSubscription action asStrongSubscriptionAction;
						subscriber: aSubscriber;
						yourself.
			anEphemeronSubscription becomeForward: aStrongSubscription.
			isRegistered ifTrue: [self addStrongSubscription: aStrongSubscription].
			aStrongSubscription]
]

{ #category : #'private - adding' }
GtMixedSubscriptionRegistry >> newEphemeronOf: aSubscriber holding: theSubscriptions [
	| anEphemeron |
	anEphemeron := WeakKeyAssociation key: aSubscriber value: theSubscriptions.
	anEphemeron container: (GtEphemeronSubscriptionsMourner registry: self
				ephemeron: anEphemeron).
	^anEphemeron
]

{ #category : #'private - accessing' }
GtMixedSubscriptionRegistry >> noteChange [
	lastChange := Object new
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> numberOfSubscriptions [
	^strongSubscriptions size + self weakPart numberOfSubscriptions
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> numberOfWeakSubscribers [
	^self weakPart numberOfSubscribers
]

{ #category : #copying }
GtMixedSubscriptionRegistry >> postCopy [
	| theWeakGroups |
	theWeakGroups := self protected: 
					[strongSubscriptions := strongSubscriptions copy.
					self weakPart subscribersWithSubscriptions].
	monitor := Mutex new.
	self weakPart: GtNoWeakSubscriptions uniqueInstance.
	theWeakGroups do: 
			[:aGroup |
			self installGroupOf: aGroup key
				holding: (IdentitySet withAll: aGroup value)]
]

{ #category : #private }
GtMixedSubscriptionRegistry >> protected: aBlock [
	^monitor critical: aBlock
]

{ #category : #private }
GtMixedSubscriptionRegistry >> protectedChange: aBlock [
	^ self
		protected: [ self noteChange.
			aBlock value ]
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> remove: aSubscription [
	^self
		protectedChange: [aSubscription removeFromMixedSubscriptionRegistry: self]
]

{ #category : #'private - finalization' }
GtMixedSubscriptionRegistry >> removeEphemeron: anEphemeron [
	self protectedChange: 
			[self weakPart: (self weakPart withoutEphemeron: anEphemeron)]
]

{ #category : #'private - removing' }
GtMixedSubscriptionRegistry >> removeStrongSubscription: aSubscription [
	^strongSubscriptions remove: aSubscription ifAbsent: []
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> removeSubscriber: aSubscriber [
	^self protectedChange: 
			[| theStrongSubscriptions theWeakSubscriptions |
			theStrongSubscriptions := strongSubscriptions
						select: [:each | each subscriber == aSubscriber].
			theStrongSubscriptions do: [:each | each unregister].
			strongSubscriptions removeAll: theStrongSubscriptions.
			theWeakSubscriptions := self weakPart subscriptionsOf: aSubscriber
						ifAbsent: [#()].
			self weakPart: (self weakPart withoutSubscriber: aSubscriber).
			theStrongSubscriptions asArray , theWeakSubscriptions asArray]
]

{ #category : #'private - removing' }
GtMixedSubscriptionRegistry >> removeWeakSubscription: aSubscription [
	| aSubscriber theSubscriptions |
	aSubscriber := aSubscription subscriber.
	theSubscriptions := self weakPart subscriptionsOf: aSubscriber
				ifAbsent: [^nil].
	theSubscriptions remove: aSubscription ifAbsent: [^nil].
	theSubscriptions
		ifEmpty: [self weakPart: (self weakPart withoutSubscriber: aSubscriber)].
	^aSubscription
]

{ #category : #'add/remove' }
GtMixedSubscriptionRegistry >> replace: aSubscription with: aNewSubscription [
	^self protectedChange: 
			[(aSubscription removeFromMixedSubscriptionRegistry: self)
				ifNil: [NotFound signalFor: aSubscription in: self].
			aNewSubscription addToMixedSubscriptionRegistry: self]
]

{ #category : #initialization }
GtMixedSubscriptionRegistry >> reset [
	self protectedChange: 
			[strongSubscriptions := IdentitySet new.
			self weakPart: GtNoWeakSubscriptions uniqueInstance]
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> subscriptions [
	^self protected: 
			[Array
				streamContents: [:aStream | self subscriptionsDo: [:each | aStream nextPut: each]]]
]

{ #category : #private }
GtMixedSubscriptionRegistry >> subscriptionsDo: aBlock [
	strongSubscriptions do: aBlock.
	self weakPart subscriptionsDo: aBlock
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> subscriptionsForClass: aSubscriberClass [
	^(self subscriptions
		select: [:each | each subscriber class includesBehavior: aSubscriberClass])
			collect: [:each | each subscriber]
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> subscriptionsHandling: anAnnouncement [
	"Answer the subscriptions that handle anAnnouncement, matched under my lock as in SubscriptionRegistry.
	Matching runs code of the subscriptions, such as a where: condition, and that code can change me while I iterate over my own collections, which can skip or repeat subscriptions. Every change stores a new object in lastChange (see #noteChange). If lastChange is no longer the object it was before matching, a change happened during matching, so I match again on a copy of my subscriptions as they are now."
	
	^self protected: 
			[| aLastChange theInterested |
			aLastChange := lastChange.
			theInterested := OrderedCollection new: 4.
			self subscriptionsDo: 
					[:each |
					(each handlesAnnouncement: anAnnouncement)
						ifTrue: [theInterested add: each]].
			aLastChange == lastChange
				ifTrue: [theInterested]
				ifFalse: 
					[self subscriptions
						select: [:each | each handlesAnnouncement: anAnnouncement]]]
]

{ #category : #iterating }
GtMixedSubscriptionRegistry >> subscriptionsOf: aSubscriber do: aBlock [
	| theSubscriptions |
	theSubscriptions := self protected: 
					[(strongSubscriptions select: [:each | each subscriber == aSubscriber])
						asArray
							, (self weakPart subscriptionsOf: aSubscriber ifAbsent: [#()]) asArray].
	theSubscriptions do: aBlock
]

{ #category : #'private - accessing' }
GtMixedSubscriptionRegistry >> weakPart [
	^weakSubscriptions
]

{ #category : #'private - accessing' }
GtMixedSubscriptionRegistry >> weakPart: aWeakPart [
	weakSubscriptions := aWeakPart
]

{ #category : #accessing }
GtMixedSubscriptionRegistry >> weakSubscribersWithSubscriptions [
	^self protected: [self weakPart subscribersWithSubscriptions]
]

{ #category : #weak }
GtMixedSubscriptionRegistry >> weakSubscriptionBuilderFor: anAnnouncer [
	^GtEphemeronSubscriptionBuilder on: anAnnouncer
]
