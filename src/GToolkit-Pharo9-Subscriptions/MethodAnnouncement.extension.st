Extension { #name : #MethodAnnouncement }

{ #category : #'*GToolkit-Pharo9-Subscriptions' }
MethodAnnouncement >> affectsMethodsDefinedInPackage: aPackage [

	^self methodPackage == aPackage or: [ self methodAffected package == aPackage ]
]

{ #category : #'*GToolkit-Pharo9-Subscriptions' }
MethodAnnouncement >> method: aCompiledMethod [
	method := aCompiledMethod.
	"methodPackage := aCompiledMethod package"
]
