Class {
	#name : #GtBlocStencilBuilderShouldImplementReset,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtBlocStencilBuilderShouldImplementReset >> doesImplementReset: aStencilClass [
	| theInstVars aResetMethod |

	theInstVars := aStencilClass instVarNames copyWithoutAll: aStencilClass stencilProperties.
	theInstVars
		ifEmpty: [ ^ true ].

	aResetMethod := aStencilClass
		compiledMethodAt: #reset
		ifAbsent: [ nil ].

	aResetMethod
		ifNil: [ ^ false ].

	(((aStencilClass allSuperclasses copyWithout: BrStencilBuilder) allSatisfy: [ :eachSuperclass | eachSuperclass instVarNames isEmpty ])
		or: [ 'super reset' gtASTMatches includesMethod: aResetMethod ])
			ifFalse: [ ^ false ].

	^ theInstVars allSatisfy: [ :eachVar |
		('{1} := `@arg.' format: { eachVar })
			gtASTMatches includesMethod: aResetMethod ]
]

{ #category : #accessing }
GtBlocStencilBuilderShouldImplementReset >> issues [
	"returns the facts that contradict the constraint"
	^ BrStencilBuilder allSubclasses reject: [ :eachStencilClass | self doesImplementReset: eachStencilClass ]
]

{ #category : #accessing }
GtBlocStencilBuilderShouldImplementReset >> name [
	^ 'StencilBuilder should implement #reset if it has inst.vars'
]
