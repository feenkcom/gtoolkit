Extension { #name : #RBRemoveTemporaryVariableTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRemoveTemporaryVariableTransformation >> applicabilityPreconditions [
	"Variable names are Symbols; the transformation gets a String"
	<gtPharoPatch: #StrictComparison>

	^ {
		  self classExist.
		  (RBCondition definesSelector: selector in: self definingClass).
		  (RBCondition
			   withBlock: [
			   self definingMethod allTemporaryVariables includes: (variableName isString ifTrue: [ variableName asSymbol ] ifFalse: [ variableName ]) ]
			   errorString: 'Method named ' , selector
				   , ' does not define a temporary variable named ' , variableName).
		  (RBCondition
			   withBlock: [
				   (self definingMethod allArgumentVariables includes:
					    (variableName isString ifTrue: [ variableName asSymbol ] ifFalse: [ variableName ])) not ]
			   errorString: 'Variable named ' , variableName
				   , ' cannot be removed because it is an argument in this method') }
]
