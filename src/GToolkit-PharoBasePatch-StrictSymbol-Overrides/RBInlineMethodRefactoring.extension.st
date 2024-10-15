Extension { #name : #RBInlineMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBInlineMethodRefactoring >> classOfTheMethodToInline [

	^ classOfTheMethodToInline
		ifNil: [ classOfTheMethodToInline := (sourceMessage receiver name = #super
					ifTrue: [ class superclass ]
					ifFalse: [ class ]) whoDefinesMethod: self inlineSelector ]
		ifNotNil: [ classOfTheMethodToInline ]
]
