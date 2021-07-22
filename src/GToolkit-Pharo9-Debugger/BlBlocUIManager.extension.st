Extension { #name : #BlBlocUIManager }

{ #category : #'*GToolkit-Pharo9-Debugger' }
BlBlocUIManager >> handleDebugRequest: aDebugRequest [
	<debuggerCompleteToSender>
	
	OupsDebuggerSystem new gtOpenDebuggerOnRequest: aDebugRequest
]
