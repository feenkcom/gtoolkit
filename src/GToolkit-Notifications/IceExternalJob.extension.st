Extension { #name : #IceExternalJob }

{ #category : #'*GToolkit-Notifications' }
IceExternalJob >> announcer [
	^ Job jobAnnouncer
]

{ #category : #'*GToolkit-Notifications' }
IceExternalJob >> children [
	^ #()
]

{ #category : #'*GToolkit-Notifications' }
IceExternalJob >> parent [
	^ nil
]
