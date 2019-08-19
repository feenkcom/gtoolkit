Extension { #name : #EvaluateCommandLineHandler }

{ #category : #'*GToolkit-World' }
EvaluateCommandLineHandler >> gtArgumentString [
	| arguments skipArguments |
	
	"Now this is ugly... Coral would be nice here! Basically we strip skipArguments if, and only if they appear at the beginning of arguments"
	skipArguments := #( '--interactive' '--no-quit' '--save' '-e' '--evaluate').

	arguments := (skipArguments includes: self arguments first)
		ifFalse: [ self arguments ]
		ifTrue: [
			(self arguments size >= 2 and: [ skipArguments includes: self arguments second ])
				ifTrue: [ self arguments allButFirst: 2 ]
				ifFalse: [ self arguments allButFirst ]].
		
	^ arguments joinUsing: Character space.
]
