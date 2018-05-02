*GToolkit-Documenter-Epicea
gtInspectorDiffIn: composite
	<gtInspectorPresentationOrder: 1>
	^ composite morph 
		title: [ 'Changes' translated ];
		morph: [ | oldString newString diffMorph |
			oldString := self content accept: EpOldStateVisitor new.
			newString := self content accept: EpNewStateVisitor new.
			diffMorph := DiffMorph from: oldString to: newString.
			oldString ifEmpty: [ diffMorph showOnlyDestination: true ].
			newString ifEmpty: [ diffMorph showOnlySource: true ].
			diffMorph ]