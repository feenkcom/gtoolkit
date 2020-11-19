Class {
	#name : #GtNotificationIcebergSshCredentials,
	#superclass : #GtNotificationIcebergCredentials,
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #defaults }
GtNotificationIcebergSshCredentials >> defaultCredentials [
	^ IceSshCredentials new
]

{ #category : #'api - accessing' }
GtNotificationIcebergSshCredentials >> elementClass [
	^ GtNotificationIcebergSshCredentialsElement
]
