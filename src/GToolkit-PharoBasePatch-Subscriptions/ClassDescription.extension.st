Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
ClassDescription >> compileSilently: sourceCode classified: protocolName notifying: requestor [
	<gtPharoPatch: #Pharo12>
	"Compile the code and classify the resulting method in the given protocol, leaving no trail in the system log, nor in any change set, nor in the 'recent submissions' list."

	^ SystemAnnouncer uniqueInstance localSuspendWhile: [ self compile: sourceCode classified: protocolName notifying: requestor ]
]
