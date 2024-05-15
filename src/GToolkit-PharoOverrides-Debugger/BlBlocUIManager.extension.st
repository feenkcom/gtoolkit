Extension { #name : #BlBlocUIManager }

{ #category : #'*GToolkit-PharoOverrides-Debugger' }
BlBlocUIManager >> handleDebugRequest: aDebugRequest [ 
	<debuggerCompleteToSender>

	OupsDebuggerSystem new gtOpenDebuggerOnRequest: aDebugRequest
]

{ #category : #'*GToolkit-PharoOverrides-Debugger' }
BlBlocUIManager >> handleDebugRequest: aDebugRequest fromDebuggerSystem: anOupsDebuggerSystem [
	<debuggerCompleteToSender>

	anOupsDebuggerSystem gtOpenDebuggerOnRequest: aDebugRequest
]

{ #category : #'*GToolkit-PharoOverrides-Debugger' }
BlBlocUIManager >> handleWarningDebugRequest: aDebugRequest [
	<debuggerCompleteToSender>
	
	OupsDebuggerSystem new gtOpenDebuggerOnRequest: aDebugRequest
]

{ #category : #'*GToolkit-PharoOverrides-Debugger' }
BlBlocUIManager >> handleWarningDebugRequest: aDebugRequest fromDebuggerSystem: anOupsDebuggerSystem [
	<debuggerCompleteToSender>
	
	anOupsDebuggerSystem gtOpenDebuggerOnRequest: aDebugRequest
]
