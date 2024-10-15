Extension { #name : #RBVariableNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBVariableNode class >> identifierNamed: anIdentifierName at: aPosition [

	anIdentifierName = 'self'
		ifTrue: [ ^ self selfNode start: aPosition ].
	anIdentifierName = 'thisContext'
		ifTrue: [ ^ self thisContextNode start: aPosition ].
	anIdentifierName = 'super'
		ifTrue: [ ^ self superNode start: aPosition ].
		
	^ self named: anIdentifierName start: aPosition
]
