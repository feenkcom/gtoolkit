Extension { #name : #RBInlineMethodFromComponentRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBInlineMethodFromComponentRefactoring >> newNameForSelf [
	"Variable names are Symbols, the generated names Strings"
	<gtPharoPatch: #StrictComparison>

	| variableName index originalName nonMetaClass |
	nonMetaClass := self nameOfTheClassOfTheMethodToInline.
	variableName := originalName := (nonMetaClass first isVowel
		                                 ifTrue: [ 'an' ]
		                                 ifFalse: [ 'a' ])
	                                , nonMetaClass.
	index := 1.

	[
	variableName := self safeVariableNameBasedOn: variableName.
	inlineParseTree allDefinedVariables anySatisfy: [ :each | each asString = variableName asString ] ]
		whileTrue: [
			variableName := originalName , index printString.
			index := index + 1 ].
	^ variableName
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBInlineMethodFromComponentRefactoring >> safeVariableNameBasedOn: aString [
	"Variable names are Symbols, the generated names Strings"
	<gtPharoPatch: #StrictComparison>
	"Creates an unused variable name containing aString"

	| baseString newString i allTempsInline allTempsSource |
	allTempsInline := inlineParseTree allTemporaryVariables.
	allTempsSource := sourceParseTree allDefinedVariables.
	baseString := aString copy.
	baseString at: 1 put: baseString first asLowercase.
	newString := baseString.
	i := 0.

	[(allTempsInline anySatisfy: [ :each | each asString = newString ])
		or: [ (allTempsSource anySatisfy: [ :each | each asString = newString ])
			or: [class definesInstanceVariable: newString]]]
			whileTrue:
				[i := i + 1.
				newString := baseString , i printString].
	^newString
]
