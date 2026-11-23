Extension { #name : #RBRenameArgumentOrTemporaryRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRenameArgumentOrTemporaryRefactoring >> prepareForExecution [
	"The old name comes from the source interval (a String), variable names are Symbols"
	<gtPharoPatch: #StrictComparison>

	| variableNode |
	oldName := self getExistingNameFromInterval.
	parseTree := class parseTreeForSelector: selector.
	variableNode := [ self
		                whichVariableNode: parseTree
		                inInterval: interval
		                name: oldName. ]
		on: OCCodeError 
		do: [ self refactoringError: 'Selected code does not contain any variables or contains multiple of them.' ].
	(variableNode isNil or: [ variableNode isVariable not ]) ifTrue: [
		self refactoringError: oldName asString , ' isn''t a valid variable' ].
	variableNode name asString = oldName asString ifFalse: [
		self refactoringError: 'Invalid selection' ].
	definingNode := variableNode whoDefines: oldName.
	definingNode ifNil: [
		self refactoringError:
			oldName asString , ' isn''t defined by the method' ]
]
