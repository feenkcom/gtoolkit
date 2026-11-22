"
I am an announcement used by {{gtClass:GtMixedSubscriptionRegistryExamples}}. I count how often I am prepared for delivery, which a registry does only when a subscription handles me ({{gtMethod:GtMixedSubscriptionRegistryExamples>>#announcementIsPreparedOnlyWhenSomeoneHandlesIt}}).
"
Class {
	#name : #GtMixedSubscriptionRegistryExampleAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'preparations'
	],
	#category : #'GToolkit-PharoBasePatch-Subscriptions-Mixed-Examples'
}

{ #category : #initialization }
GtMixedSubscriptionRegistryExampleAnnouncement >> initialize [
	super initialize.
	preparations := 0
]

{ #category : #accessing }
GtMixedSubscriptionRegistryExampleAnnouncement >> preparations [
	^preparations
]

{ #category : #initialization }
GtMixedSubscriptionRegistryExampleAnnouncement >> prepareForDelivery [
	preparations := preparations + 1
]
