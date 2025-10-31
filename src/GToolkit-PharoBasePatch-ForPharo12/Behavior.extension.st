Extension { #name : #Behavior }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
Behavior >> removeSelectorSilently: selector [
	<gtPharoPatch: #Pharo12>
	"Remove selector without sending system change notifications"
	<reflection: 'Class structural modification - Selector/Method modification'>
	^ SystemAnnouncer uniqueInstance localSuspendWhile: [self removeSelector: selector]
]
