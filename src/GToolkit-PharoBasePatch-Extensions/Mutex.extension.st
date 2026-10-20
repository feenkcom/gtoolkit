Extension { #name : #Mutex }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Mutex >> criticalReleasingOnError: aBlock [
	"Execute aBlock with mutual exclusion, allowing reentrant calls.
	Release ownership before passing an exception to the semaphore's handler,
	which releases the semaphore before invoking external exception handlers.
	Resuming an exception does not reacquire the mutex."
	| activeProcess released |
	
	activeProcess := Processor activeProcess.
	activeProcess == owner ifTrue: [ ^ aBlock value ].
	^ semaphore criticalReleasingOnError: [
		released := false.
		owner := activeProcess.
		[
			aBlock
				on: Exception
				do: [ :exception |
					released ifFalse: [
						released := true.
						owner := nil ].
					exception pass ]
		] ensure: [ released ifFalse: [ owner := nil ] ] ]
]
