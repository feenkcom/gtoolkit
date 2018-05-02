instance creation
newApplyChangesButtonModel
	| aLabel aModel |
	aLabel := epiceaLog hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
	aModel := BrButtonModel new
		label: aLabel;
		action: [ epiceaLog applyCodeChanges ].
	epiceaLog onImpactChangedDo: [ :anAnnouncement | | newValue |
		newValue := anAnnouncement hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
		aModel label: newValue ].
	^ aModel