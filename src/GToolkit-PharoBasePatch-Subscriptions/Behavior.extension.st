Extension { #name : #Behavior }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Behavior >> recompile: selector from: oldClass [
	<gtPharoPatch: #Pharo12>
	"Compile the method associated with selector in the receiver's method dictionary."

	| method newMethod |

	"Recompilation should be done silently, to avoid putting noise in the system"
	self codeChangeAnnouncer localSuspendWhile: [
		method := oldClass compiledMethodAt: selector.
		newMethod := oldClass compiler
			             source: (oldClass sourceCodeAt: selector);
			             priorMethod: method;
			             class: self;
			             permitFaulty: true;
			             "No need to log recompilation in the sources,
						 	 We are going to reuse the original source pointer."
			             logged: false;
			             install ].

	newMethod sourcePointer: method sourcePointer.
	selector == newMethod selector ifFalse: [
		self error: 'selector changed!' ]
]

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
Behavior >> removeSelectorSilently: selector [
	<gtPharoPatch: #Pharo12>
	"Remove selector without sending system change notifications"
	<reflection: 'Class structural modification - Selector/Method modification'>
	^ self codeChangeAnnouncer localSuspendWhile: [self removeSelector: selector]
]
