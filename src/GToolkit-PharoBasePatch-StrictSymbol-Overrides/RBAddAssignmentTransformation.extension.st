Extension { #name : #RBAddAssignmentTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAddAssignmentTransformation >> applicabilityPreconditions [
	"The variable name can be a Symbol"
	<gtPharoPatch: #StrictComparison>

	^ {
		  self classExist.
		  (RBCondition
			   withBlock: [ self definingClass canUnderstand: selector ]
			   errorString:
			   ('Method named <1s> does not exist' expandMacrosWith: selector)).
		  (RBCondition
			   withBlock: [
				   (self definingMethod allChildren
					    select: [ :each | each isVariable ]
					    thenCollect: [ :each | each name ]) anySatisfy: [ :e |
					   e asString = variableName asString ] ]
			   errorString:
				   ('Method named <1s> does not have a variable named <2s>'
					    expandMacrosWith: selector
					    with: variableName)) }
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAddAssignmentTransformation >> privateTransform [
	"The variable name can be a Symbol"
	<gtPharoPatch: #StrictComparison>
	"if the variable was previously assigned, the transformation adds
	 this assignment as the last one"

	| methodTree assignmentNode assignments previousNode |
	methodTree := self definingMethod.
	assignmentNode := OCAssignmentNode
		variable: (OCVariableNode named: variableName)
		value: (self parserClass parseExpression: value).

	"check whether there are some dependencies in the expression"
	assignments := (methodTree allChildren select: #isAssignment)
		select: [ :each | each variable name asString = variableName asString ].
	previousNode := assignments detectMax: #stop.
	previousNode
		ifNil: [ methodTree body addNodeFirst: assignmentNode ]
		ifNotNil: [ previousNode parent addNode: assignmentNode after: previousNode ].
	class compileTree: methodTree
]
