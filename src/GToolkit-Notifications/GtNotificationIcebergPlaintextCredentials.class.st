Class {
	#name : #GtNotificationIcebergPlaintextCredentials,
	#superclass : #GtNotificationIcebergCredentials,
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #defaults }
GtNotificationIcebergPlaintextCredentials >> defaultCredentials [
	^ IcePlaintextCredentials new
]

{ #category : #'api - accessing' }
GtNotificationIcebergPlaintextCredentials >> elementClass [
	^ GtNotificationIcebergPlaintextCredentialsElement
]
