Extension { #name : #RBMoveMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBMoveMethodRefactoring >> compileDelegatorMethod [
	| statementNode delegatorNode tree |
	delegatorNode := RBMessageNode
			receiver: (RBVariableNode named: variable)
			selector: parseTree selector
			keywordsPositions: parseTree keywordsPositions
			arguments: (parseTree argumentNames
					collect: [ :each | 
						(each sameContentAs: selfVariableName)
							ifTrue: [ RBVariableNode selfNode ]
							ifFalse: [ RBVariableNode named: each ] ]).
	self hasOnlySelfReturns
		ifFalse: [ delegatorNode := RBReturnNode value: delegatorNode ].
	statementNode := RBSequenceNode
			temporaries: #()
			statements: (Array with: delegatorNode).
	(tree := class parseTreeForSelector: selector) body: statementNode.
	class compileTree: tree
]
