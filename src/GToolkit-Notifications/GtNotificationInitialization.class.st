"
I initialize ${class:BlBlocUIManagerNotification}$.
See ${method:GtNotificationInitialization class>>#initialize|expanded=true}$.
"
Class {
	#name : #GtNotificationInitialization,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-System Configuration'
}

{ #category : #'class initialization' }
GtNotificationInitialization class >> initialize [
	"Handlers must return an object that understands #asElement message."
	BlBlocUIManagerNotification notificationHandlers
		at: #inform: 
		put: [ :request :args |
			GtNotificationMessage message: args first ]
]
