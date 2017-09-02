as yet unclassified
runThenDo: aBlock1 onErrorDo: aBlock2
	| result |
	^ (result := self run) isSuccess 
		ifTrue: [ aBlock1 value: result ]
		ifFalse: [ aBlock2 value: result ]