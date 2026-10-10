Extension { #name : #OCUndeclaredVariableWarning }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OCUndeclaredVariableWarning >> location [
	<gtPharoPatch: #Pharo>
	
	^ self node sourceInterval first
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OCUndeclaredVariableWarning >> messageText [ 
	^ (super messageText isNil or: [
		super messageText isEmpty ]) ifTrue: [
			'Undeclared temp: ', self node  name ]
]
