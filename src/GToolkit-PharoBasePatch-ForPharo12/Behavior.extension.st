Extension { #name : #Behavior }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
Behavior >> recompile: selector from: oldClass [
	"Compile the method associated with selector in the receiver's method dictionary."

	<gtPharoPatch: #Pharo12>
	self
		forPharo12AndNewer: [ | method newMethod |
			"Recompilation should be done silently, to avoid putting noise in the system"
			SystemAnnouncer uniqueInstance
				localSuspendWhile: [ method := oldClass compiledMethodAt: selector.
					newMethod := oldClass compiler
							source: (oldClass sourceCodeAt: selector);
							priorMethod: method;
							class: self;
							permitFaulty: true;
							logged: false;
							install	"No need to log recompilation in the sources,
						 	 We are going to reuse the original source pointer." ].

			newMethod sourcePointer: method sourcePointer.
			selector == newMethod selector ifFalse: [ self error: 'selector changed!' ] ]
		forPharo11: [ | method newMethod |
			method := oldClass compiledMethodAt: selector.
			newMethod := oldClass compiler
					source: (oldClass sourceCodeAt: selector);
					class: self;
					failBlock: [ ^ self ];
					compiledMethodTrailer: method trailer;
					compile.	"Assume OK after proceed from SyntaxError"
			selector == newMethod selector ifFalse: [ self error: 'selector changed!' ].
			self addSelector: selector withRecompiledMethod: newMethod ]
]

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
Behavior >> removeSelectorSilently: selector [
	<gtPharoPatch: #Pharo12>
	"Remove selector without sending system change notifications"
	<reflection: 'Class structural modification - Selector/Method modification'>
	^ SystemAnnouncer uniqueInstance localSuspendWhile: [self removeSelector: selector]
]
