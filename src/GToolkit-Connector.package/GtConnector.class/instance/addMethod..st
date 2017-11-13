public
addMethod: aMethod
	| anEditorElement |

	(self hasOpenedMethod: aMethod)
		ifTrue: [ ^ self ].

	anEditorElement := self createAndAddElementForMethod: aMethod.
	anEditorElement
		when: GtConnectorButtonsChangedInElement
		do: [ :anEvent | anEvent newButtons do: [ :newButton | self connectButton: newButton ] ].
	
	self editorElements do: [ :each | each ~= aMethod ifTrue: [each editor styler styleInBackgroundProcess: each editor text copy ] ].
	
	