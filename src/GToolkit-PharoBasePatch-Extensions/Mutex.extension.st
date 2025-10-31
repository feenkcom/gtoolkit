Extension { #name : #Mutex }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Mutex >> criticalReleasingOnError: aBlock [
	"Execute aBlock only if the receiver is not already used by another process.
	If it is, wait until the resource is available.
	If the mutex is already used by the current process, execution proceeds.
	Answer the block's result."

	| activeProcess |
	activeProcess := Processor activeProcess.
	activeProcess == owner ifTrue:[ ^aBlock value ].
	^ semaphore criticalReleasingOnError: [
			owner := activeProcess.
			aBlock ensure: [ owner := nil ] ]
]
