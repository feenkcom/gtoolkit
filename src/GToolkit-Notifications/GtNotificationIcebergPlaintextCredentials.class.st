"
I am a {{gtClass:GtNotificationIcebergCredentials}}.
I am used to notify that {{gtClass:IcePlaintextCredentials|label=plaintext}} credentials are requested. Those credentials are used to login in to [GitHub](https://github.com) and similar Git repositories.
## Example 
{{gtExample:GtNotificationIcebergCredentialsExamples>>#plaintextCredentialsNotificationWithUsernameAndPassword|codeExpanded=false|previewExpanded=true}}

"
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
