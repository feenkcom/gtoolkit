"
I am a ${class:GtNotificationIcebergCredentials}$.
I am used to notify that ${class:IceSshCredentials|label=SSH}$ credentials are requested. Those credentials are used to login in to *GitHub>https://github.com* and similar Git repositories.
!! Example 
${example:GtNotificationIcebergCredentialsExamples>>#sshCredentialsNotificationWithKeys|codeExpanded=false|previewExpanded=true}$
"
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
