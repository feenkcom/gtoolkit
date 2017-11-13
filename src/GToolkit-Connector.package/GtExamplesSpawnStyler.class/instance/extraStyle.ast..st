private
extraStyle: aText ast: ast
	| selfSendsExamples newButtonAttributes |
	newButtonAttributes := OrderedCollection new.
	selfSendsExamples := ast allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [
					(ast methodNode methodClass canPerform: each selector) and: [ 
						(ast methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ].
	selfSendsExamples do: [ :each | 
		| buttonAttribute targetExampleMethod |
		targetExampleMethod := ast methodNode methodClass lookupSelector: each selector.
		buttonAttribute := BrTextActionButtonAttribute new.
		buttonAttribute 
			source: ast method;
			target: targetExampleMethod.
		newButtonAttributes add: buttonAttribute.
		buttonAttribute
				actionBlock: [ :ev | 
					exampleAction 
						value: targetExampleMethod
						value: each
						value: buttonAttribute ].
		aText 
			attributes: { buttonAttribute } 
			from: each stop - 1
			to: each stop ].
	self dispatchEvent: (GtConnectorButtonsChangedByStyler new
		newButtons: (newButtonAttributes);
		oldButtons: (buttonAttributes)).
	buttonAttributes := newButtonAttributes