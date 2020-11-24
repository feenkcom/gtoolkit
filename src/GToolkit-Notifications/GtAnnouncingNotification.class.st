Class {
	#name : #GtAnnouncingNotification,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #announcer }
GtAnnouncingNotification >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtAnnouncingNotification >> gtSubscriptionsFor: aView [
	<gtView>
	self announcer ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Subscriptions';
		priority: 10;
		object: [ self announcer ];
		view: #gtSubscriptionsFor:
]

{ #category : #initialization }
GtAnnouncingNotification >> initialize [
	super initialize.
	announcer := Announcer new.
]
