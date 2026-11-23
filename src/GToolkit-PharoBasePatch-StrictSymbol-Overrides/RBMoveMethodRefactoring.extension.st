Extension { #name : #RBMoveMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBMoveMethodRefactoring >> compileDelegatorMethod [
	"Argument names are Symbols, the self variable name a String"
	<gtPharoPatch: #StrictComparison>
	| statementNode delegatorNode tree |
	delegatorNode := OCMessageNode
		                 receiver: (OCVariableNode named: variable)
		                 selector: parseTree selector
		                 keywordsPositions: parseTree keywordsPositions
		                 arguments: (parseTree argumentNames collect: [ :each |
				                  (selfVariableName isString and: [ each asString = selfVariableName asString ])
					                  ifTrue: [ OCVariableNode selfNode ]
					                  ifFalse: [ OCVariableNode named: each ] ]).
	self hasOnlySelfReturns ifFalse: [ delegatorNode := OCReturnNode value: delegatorNode ].
	statementNode := OCSequenceNode temporaries: #(  ) statements: (Array with: delegatorNode).
	(tree := class parseTreeForSelector: selector) body: statementNode.
	class compileTree: tree
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBMoveMethodRefactoring >> isMovingToArgument [
	"Argument names are Symbols; the variable name can be a String (GT passes Strings)"
	<gtPharoPatch: #StrictComparison>
	^(parseTree arguments collect: [:each | each name]) includes: (variable isString ifTrue: [ variable asSymbol ] ifFalse: [ variable ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBMoveMethodRefactoring >> removeArgument [
	"Argument names are Symbols; the variable name can be a String (GT passes Strings)"
	<gtPharoPatch: #StrictComparison>
	"Removes the excess argument if any.
	This argument is the variable which is
	referenced by self in the classes the
	method is moved to. "
	| removeIndex |
	removeIndex := parseTree argumentNames indexOf: (variable isString ifTrue: [ variable asSymbol ] ifFalse: [ variable ]).
	removeIndex = 0 ifFalse:
		[parseTree
			selector: ('' join: ((parseTree selector keywords asOrderedCollection)
									removeAt: removeIndex; yourself)) asSymbol
			keywordsPositions: ((parseTree keywordsPositions asOrderedCollection)
									removeAt: removeIndex; yourself) asIntegerArray
			arguments: ((parseTree arguments asOrderedCollection)
									removeAt: removeIndex; yourself) asArray]
]
