Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
CompiledMethod >> protocolName [
	"Return the name of the protocol (conceptual groups of methods) in which the receiver is grouped into."

	^ self 
		forPharo12AndNewer: [ self protocol ifNotNil: [ :protocol | protocol name ] ] 
		forPharo11: [ self category ]
]
