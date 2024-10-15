Extension { #name : #SessionCategory }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SessionCategory >> renamedClass: aClass from: oldName to: newName [
	priorityLists
		do: [ :handlers | 
			handlers
				detect: [ :handler | handler handledId sameContentAs: oldName ]
				ifFound: [ :handler | handler registeredClassName: newName ] ]
]
