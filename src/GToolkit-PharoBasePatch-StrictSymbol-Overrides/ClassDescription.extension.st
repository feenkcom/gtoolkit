Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ClassDescription >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: category [
	| priorMethodOrNil priorOriginOrNil oldProtocol newProtocol |
	priorMethodOrNil := self compiledMethodAt: selector ifAbsent: [ nil ].
	priorMethodOrNil ifNotNil: [ priorOriginOrNil := priorMethodOrNil origin ].

	self addSelectorSilently: selector withMethod: compiledMethod.

	oldProtocol := self organization categoryOfElement: selector.
	SystemAnnouncer uniqueInstance
		suspendAllWhile: [ self organization
				classify: selector
				under: ((category sameContentAs: Protocol unclassified)
						ifTrue: [ oldProtocol ]
						ifFalse: [ category ]) ].
	newProtocol := self organization categoryOfElement: selector.

	self isAnonymous ifTrue: [ ^ self ].

	(priorMethodOrNil isNil or: [ priorOriginOrNil ~= compiledMethod origin ])
		ifTrue: [ SystemAnnouncer uniqueInstance methodAdded: compiledMethod ]
		ifFalse: [  "If protocol changed and someone is from different package, I need to throw a method recategorized"self
				notifyRepackage: selector
				method: compiledMethod
				oldProtocol: oldProtocol
				newProtocol: newProtocol.

			SystemAnnouncer uniqueInstance
				methodChangedFrom: priorMethodOrNil
				to: compiledMethod
				oldProtocol: oldProtocol ]
]
