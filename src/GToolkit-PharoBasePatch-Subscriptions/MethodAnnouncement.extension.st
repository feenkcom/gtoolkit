Extension { #name : #MethodAnnouncement }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MethodAnnouncement >> affectsMethodsDefinedInPackage: aPackage [
	<gtPharoPatch: #Pharo>
	
	"Patch to use the #methodPackage method so that the package can be computed lazily."
	^self methodPackage == aPackage or: [ self methodAffected package == aPackage ]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
MethodAnnouncement >> method: aCompiledMethod [
	<gtPharoPatch: #Pharo>
	
	method := aCompiledMethod.
	
	"We comment this out so that the package will be computed lazily only if needed"
	"methodPackage := aCompiledMethod package"
]
