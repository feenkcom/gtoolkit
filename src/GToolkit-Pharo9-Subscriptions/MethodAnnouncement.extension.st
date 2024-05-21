Extension { #name : #MethodAnnouncement }

{ #category : #'*GToolkit-Pharo9-Subscriptions' }
MethodAnnouncement >> affectsMethodsDefinedInPackage: aPackage [
	<gtPharoPatch: #Pharo>
	
	^self methodPackage == aPackage or: [ self methodAffected package == aPackage ]
]

{ #category : #'*GToolkit-Pharo9-Subscriptions' }
MethodAnnouncement >> method: aCompiledMethod [
	<gtPharoPatch: #Pharo>
	
	method := aCompiledMethod.
	"methodPackage := aCompiledMethod package"
]
