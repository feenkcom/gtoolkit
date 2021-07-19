Extension { #name : #BlBlocUIManager }

{ #category : #'*GToolkit-Debugger-Pharo9' }
BlBlocUIManager >> handleDebugRequest: aDebugRequest [
	<debuggerCompleteToSender>
	
	OupsDebuggerSystem new gtOpenDebuggerOnRequest: aDebugRequest
]
