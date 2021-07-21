Extension { #name : #RBVariableNode }

{ #category : #'*GToolkit-Pharo9-Deprecations' }
RBVariableNode >> isGlobal [
	"isGlobal used to return true for both class variables and globals (and even undeclared Variables).
	From Pharo9 on, #isGlobalVariable returns true only for real globals"

	^self isLiteralVariable
]
