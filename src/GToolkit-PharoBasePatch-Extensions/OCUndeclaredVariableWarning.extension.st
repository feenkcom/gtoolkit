Extension { #name : #OCUndeclaredVariableWarning }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OCUndeclaredVariableWarning >> location [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [
			self node sourceInterval first ] 
		forPharo11: [ super location ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OCUndeclaredVariableWarning >> messageText [ 
	^ (super messageText isNil or: [
		super messageText isEmpty ]) ifTrue: [
			'Undeclared temp: ', self node  name ]
]
