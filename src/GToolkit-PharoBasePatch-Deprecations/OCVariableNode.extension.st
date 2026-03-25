Extension { #name : #OCVariableNode }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
OCVariableNode >> isBlockVar [
	<gtPharoPatch: #Pharo>
	
	^self isDefinedByBlock
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
OCVariableNode >> isGlobal [
	<gtPharoPatch: #Pharo>
	
	"isGlobal used to return true for both class variables and globals (and even undeclared Variables).
	From Pharo9 on, #isGlobalVariable returns true only for real globals"

	^self isLiteralVariable
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
OCVariableNode >> isTemp [
	<gtPharoPatch: #Pharo>
	
	^ self isTempVariable
]
