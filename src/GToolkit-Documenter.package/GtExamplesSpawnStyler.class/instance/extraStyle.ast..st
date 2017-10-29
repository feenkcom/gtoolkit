private
extraStyle: aText ast: ast
	| selfSendsExamples |
	selfSendsExamples := ast allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [
					(ast methodNode methodClass canPerform: each selector) and: [ 
						(ast methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ].
	selfSendsExamples do: [ :each | 
		| buttonAttribute |
		buttonAttribute := BrTextActionButtonAttribute new.
		buttonAttribute
				actionBlock: [ :ev | 
					exampleAction 
						value: (ast methodNode methodClass lookupSelector: each selector)
						value: each
						value: buttonAttribute ].
		aText 
			attributes: { buttonAttribute } 
			from: each stop - 1
			to: each stop ]