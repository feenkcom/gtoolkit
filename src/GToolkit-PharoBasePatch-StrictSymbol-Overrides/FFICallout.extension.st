Extension { #name : #FFICallout }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> loaderForArgNamed: argName [
	| loader |

	"try getting the argument from the method arguments"
	loader := self loaderFromMethodArgsNamed: argName.
	loader
		ifNil: [  "special case, receiver argument"argName = #self
				ifTrue: [ loader := self receiverArgumentLoader ].
			loader
				ifNil: [  "Ask the requestor for the argument"loader := requestor
							ffiInstVarArgument: argName
							generator: self.
					loader
						ifNil: [ | binding |
							binding := requestor ffiBindingOf: argName.
							binding ifNil: [ FFIVariableNameNotFound signalFor: argName ].
							loader := FFIClassVariableArgument new
									argName: argName;
									yourself ] ] ].
	^ loader
]
