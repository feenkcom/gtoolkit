Class {
	#name : #FastSubscriptionRegistryExamples,
	#superclass : #Object,
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Examples'
}

{ #category : #accessing }
FastSubscriptionRegistryExamples >> registryAddingAndRemoving [

	<gtExample>
	| reg sub1 sub2 |
	reg := FastSubscriptionRegistry new.
	sub1 := AnnouncementSubscription new
		        subscriber: self;
		        announcementClass: JobStart;
		        yourself.
	sub2 := AnnouncementSubscription new
		        subscriber: self;
		        announcementClass: JobEnd;
		        yourself.

	self assert: reg numberOfSubscriptions == 0.
	self assert: (reg handleEventClass: JobStart) not.
	self assert: (reg handleEventClass: JobEnd) not.
	self assert: (reg hasSubscriber: self) not.

	reg add: sub1.

	self assert: reg numberOfSubscriptions == 1.
	self assert: (reg handleEventClass: JobStart).
	self assert: (reg handleEventClass: JobEnd) not.
	self assert: (reg subscriptionsForClass: self class) size == 1.
	self assert: ((reg subscriptionsForClass: self class) includes: sub1).
	self assert:
		((reg subscriptionsHandling: JobStart new) includes: sub1).
	self assert:
		((reg subscriptionsHandling: JobEnd new) includes: sub2) not.
	self assert: (reg hasSubscriber: self).

	reg add: sub2.

	self assert: reg numberOfSubscriptions == 2.
	self assert: (reg handleEventClass: JobStart).
	self assert: (reg handleEventClass: JobEnd).
	self assert: (reg subscriptionsForClass: self class) size == 2.
	self assert: ((reg subscriptionsForClass: self class) includes: sub1).
	self assert: ((reg subscriptionsForClass: self class) includes: sub2).
	self assert:
		((reg subscriptionsHandling: JobStart new) includes: sub1).
	self assert: ((reg subscriptionsHandling: JobEnd new) includes: sub2). 
	self assert: (reg hasSubscriber: self).
	
	reg removeSubscriber: self.
	self assert: reg numberOfSubscriptions == 0.
	self assert: (reg handleEventClass: JobStart) not.
	self assert: (reg handleEventClass: JobEnd) not.
	self assert: (reg hasSubscriber: self) not.

	^ reg
]

{ #category : #accessing }
FastSubscriptionRegistryExamples >> registryCreation [
	<gtExample>
	| reg |
	reg := FastSubscriptionRegistry new.
	self assert: reg numberOfSubscriptions == 0.
	^reg
]

{ #category : #accessing }
FastSubscriptionRegistryExamples >> registryWithBlockAnnouncements [
	<gtExample>
	| reg |
	reg := FastSubscriptionRegistry new.
	self assert: reg numberOfSubscriptions == 0.
	^reg
]
