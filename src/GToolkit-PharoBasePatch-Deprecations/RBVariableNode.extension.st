Extension { #name : #RBVariableNode }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
RBVariableNode >> isBlockVar [
	<gtPharoPatch: #Pharo>
	
	^self isDefinedByBlock
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
RBVariableNode >> isGlobal [
	<gtPharoPatch: #Pharo>
	
	"isGlobal used to return true for both class variables and globals (and even undeclared Variables).
	From Pharo9 on, #isGlobalVariable returns true only for real globals"

	^self isLiteralVariable
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
RBVariableNode >> isTemp [
	<gtPharoPatch: #Pharo>
	
	^ self isTempVariable
]
