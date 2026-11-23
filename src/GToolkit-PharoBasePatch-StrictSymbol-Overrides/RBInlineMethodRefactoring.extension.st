Extension { #name : #RBInlineMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBInlineMethodRefactoring >> classOfTheMethodToInline [
	"Variable names are Symbols"
	<gtPharoPatch: #StrictComparison>

	^ classOfTheMethodToInline
		  ifNil: [
			  classOfTheMethodToInline := (sourceMessage receiver name
			                               = #super
				                               ifTrue: [ class superclass ]
				                               ifFalse: [ class ])
				                              whichClassIncludesSelector:
				                              self inlineSelector ]
		  ifNotNil: [ classOfTheMethodToInline ]
]
