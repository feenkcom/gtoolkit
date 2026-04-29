Extension { #name : #Object }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Object >> explicitRequirement [
	"If one of the superclasses can perform the selector, we execute the method of that class, otherwise, the explicit requirement error is thrown"

	<debuggerCompleteToSender>
	
	| sender |
	sender := thisContext sender.
	[ sender return: (self perform: sender selector withArguments: sender arguments inSuperclass: sender methodClass superclass) ]
		on: MessageNotUnderstood
		do: [ self error: 'Explicitly required method' ]
]
