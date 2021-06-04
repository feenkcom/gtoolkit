"
I am a {{gtClass:GtNotificationIcebergCredentials}}.
I am used to notify that {{gtClass:IceSshCredentials|label=SSH}} credentials are requested. Those credentials are used to login in to [GitHub](https://github.com) and similar Git repositories.
1. # Example 

{{gtExample:GtNotificationIcebergCredentialsExamples>>#sshCredentialsNotificationWithKeys|codeExpanded=false|previewExpanded=true}}


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
