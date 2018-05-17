instance creation
newApplyChangesButtonModel
	| aLabel aModel |
	aLabel := self epiceaLog hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
	aModel := BrButtonModel new
		label: aLabel;
		action: [ self epiceaLog applyCodeChanges ].
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | | newValue |
			newValue := anAnnouncement hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
			aModel label: newValue ].
	^ aModel