"
I initialize ${class:BlBlocUIManagerNotification}$.
See ${method:GtNotificationInitialization class>>#initialize|expanded=true}$.
"
Class {
	#name : #GtNotificationInitialization,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Initialization'
}

{ #category : #'class initialization' }
GtNotificationInitialization class >> initialize [
	"Handlers must return an object that understands #asElement message."
	BlBlocUIManagerNotification notificationHandlers
		at: #inform: 
		put: [ :request :args |
			GtNotificationMessageEvent message: args first ]
]
