Extension { #name : #OupsDebuggerSystem }

{ #category : #'*GToolkit-Debugger-Pharo9' }
OupsDebuggerSystem >> gtOpenDebuggerOnRequest: aDebugRequest [

	"Prepare the opening of a debugger, and delegate the debugger selection and opening to a strategy"

	<debuggerCompleteToSender>
	| isForBlocUIProcess aBlocUniverseIfAny aDebuggerOpeningAction |
	
	aDebugRequest debugSession logStackToFileIfNeeded.
	self performPreDebugActionsIn: aDebugRequest.
	
	(self gtSpawnNewUIProcessIfNecessary: aDebugRequest) in: [ :values |
		isForBlocUIProcess := values first.
		aBlocUniverseIfAny := values second ].
	self ensureExceptionIn: aDebugRequest debugSession.
	
	aDebuggerOpeningAction := [
		GtMoldableDebugger
				openOn: aDebugRequest debugSession
				 withFullView: nil
				 andNotification: nil ].
	
	"Perform the opening of the debugger in defer action to suspend the UI."
	isForBlocUIProcess
		ifTrue: [ self defaultUIManager defer: aDebuggerOpeningAction universe: aBlocUniverseIfAny ]
		ifFalse: [ aDebugRequest debugSession isAboutUIProcess
			ifTrue: [ self defaultUIManager defer: aDebuggerOpeningAction ]
			ifFalse: [ self defaultUIManager
				universeDo: [ :aBlocUniverse | self defaultUIManager defer: aDebuggerOpeningAction universe: aBlocUniverse  ]
				ifAbsent: [ self defaultUIManager defer: aDebuggerOpeningAction ] ] ].
	

	self suspendDebuggedProcess: aDebugRequest
]

{ #category : #'*GToolkit-Debugger-Pharo9' }
OupsDebuggerSystem >> gtSpawnNewUIProcessIfNecessary: aDebugRequest [

	"If aDebugRequest is about debugging the UI process, we must create a new UI process to take its place. Because the debugged process will be suspended at some point, and suspending the UI process means freezing the UI of the image"
	| isForBlocUIProcess aBlocUniverseIfAny |
	isForBlocUIProcess := false.
	aBlocUniverseIfAny := nil.
	
	self defaultUIManager
		universeForSession: aDebugRequest debugSession
		ifPresent: [ :aUniverse |
			isForBlocUIProcess := true.
			aBlocUniverseIfAny := aUniverse.
			aDebugRequest debugSession errorWasInUIProcess: true ]
		ifAbsent: [].
	
	aDebugRequest debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
			isForBlocUIProcess "Handle the case of the Bloc UI process"
				ifTrue: [ self defaultUIManager spawnNewBlocProcess: aBlocUniverseIfAny ]
				ifFalse: [ self defaultUIManager spawnNewProcess ] ] ].
	
	^ { isForBlocUIProcess . aBlocUniverseIfAny }
]
