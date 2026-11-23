Extension { #name : #RBAddParameterTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAddParameterTransformation >> checkSendersAccessTo: name [
	"Variable names can be Symbols"
	<gtPharoPatch: #StrictComparison>

	(name isString and: [ #('self' 'super') includes: name asString ]) ifTrue: [ ^ self ].
	self senders
		detect: [ :each | (self canReferenceVariable: name in: each) not ]
		ifFound: [ :violatorClass |
			self
				refactoringError:
					('<1s> doesn''t appear to be defined in <2p>'
						expandMacrosWith: name
						with: violatorClass) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAddParameterTransformation >> safeVariableNameFor: aClass temporaries: allTempVars [
	"The temporary names are Symbols, the generated names Strings"
	<gtPharoPatch: #StrictComparison>
	| baseString index newString |
	newString := baseString := 'anObject'.
	index := 0.

	[(allTempVars anySatisfy: [ :each | each asString = newString ])
		or: [aClass definesInstanceVariable: newString]]
			whileTrue:
				[index := index + 1.
				newString := baseString , index printString].
	^newString
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAddParameterTransformation >> safeVariableNamed: argName for: aClass temporaries: allTempVars [
	"The temporary names are Symbols, the generated names Strings"
	<gtPharoPatch: #StrictComparison>
	| baseString index newString |
	((allTempVars anySatisfy: [ :each | each asString = argName asString ])
		or: [aClass definesInstanceVariable: argName]) ifFalse: [ ^ argName ].
	newString := baseString := 'anObject'.
	index := 0.

	[(allTempVars anySatisfy: [ :each | each asString = newString ])
		or: [aClass definesInstanceVariable: newString]]
			whileTrue:
				[index := index + 1.
				newString := baseString , index printString].
	^newString
]
