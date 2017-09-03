private
extraStyle: aText ast: ast
	| selfSendsExamples |

	selfSendsExamples := ast allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [ 
					(ast methodNode methodClass canPerform: each selector) and: [ 
						(ast methodNode methodClass lookupSelector: each selector) isGtExampleMethod ] ] ] ] ].
	selfSendsExamples do: [ :each | 
		aText 
			attributes: { 
				BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
					BrTextAdornmentDynamicAttribute new beAppend; elementBlock: [	 
						| editorElement |
						editorElement := self class 
							editorElementOnSourceCode: (ast methodNode methodClass lookupSelector: each selector) sourceCode
							inClass: ast methodNode methodClass.
						editorElement margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ]] } 
			from: each start
			to: each stop ].
	(ast pragmas anySatisfy: [ :each | each selector = #gtExample ]) ifTrue: [ 
		ast pragmas do: [ :each |
			each selector = #dependsOn: ifTrue: [ 
				aText 
					attributes: { 
					BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
						BrTextAdornmentDynamicAttribute new beAppend; elementBlock: [	 
							| editorElement |
							editorElement := self class 
								editorElementOnSourceCode: (ast methodNode methodClass >> each arguments anyOne value) sourceCode
								inClass: ast methodNode methodClass.
							editorElement margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ]] } 
					from: each left
					to: each right ] ] ]