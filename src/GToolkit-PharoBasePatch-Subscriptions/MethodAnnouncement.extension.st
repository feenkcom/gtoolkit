Extension { #name : #MethodAnnouncement }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MethodAnnouncement >> affectsMethodsDefinedInPackage: aPackage [
	<gtPharoPatch: #Pharo>
	
	^self methodPackage == aPackage or: [ self methodAffected package == aPackage ]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MethodAnnouncement >> method: aCompiledMethod [
	<gtPharoPatch: #Pharo>
	
	method := aCompiledMethod.
	"methodPackage := aCompiledMethod package"
]
