Class {
	#name : #GtNotifications,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'collection',
		'mutex',
		'announcer'
	],
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #'api - adding / removing' }
GtNotifications >> addNotification: aNotification [
	mutex critical: [ 
		collection addFirst: aNotification ].
	self notifyNotificationsChanged.
]

{ #category : #announcer }
GtNotifications >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'api - converting' }
GtNotifications >> asArray [
	^ mutex critical: [ 
		collection asArray ]
]

{ #category : #'gt-extensions' }
GtNotifications >> gtNotificationsFor: aView [
	<gtView>
	collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Notifications';
		items: [ self asArray ];
		updateWhen: GtNotificationsChangedAnnouncement in: self
]

{ #category : #initialization }
GtNotifications >> initialize [
	super initialize.
	mutex := Mutex new.
	collection := LinkedList new.
	announcer := Announcer new.
]

{ #category : #'private - notifying' }
GtNotifications >> notifyNotificationsChanged [
	self announce: (GtNotificationsChangedAnnouncement new notifications: self)
]

{ #category : #'api - adding / removing' }
GtNotifications >> removeNotification: aNotification [
	mutex critical: [ 
		collection 
			remove: aNotification
			ifAbsent: [ "ignore" ^ self ] ].
	self notifyNotificationsChanged.
]

{ #category : #'api - accessing' }
GtNotifications >> size [
	<return: #Integer>
	^ collection size
]
