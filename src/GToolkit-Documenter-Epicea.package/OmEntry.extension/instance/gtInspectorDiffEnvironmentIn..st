*GToolkit-Documenter-Epicea
gtInspectorDiffEnvironmentIn: composite
	<gtInspectorPresentationOrder: 2>
	^ composite morph 
		title: [ 'Changes Environment' translated ];
		morph: [ | oldString newString diffMorph |
			oldString := self content accept: (
				GtEpiceaCurrentStateVisitor inEnvironment: 
					self class environment).
			newString := self content accept: EpNewStateVisitor new.
			diffMorph := DiffMorph from: oldString to: newString.
			oldString ifEmpty: [ diffMorph showOnlyDestination: true ].
			newString ifEmpty: [ diffMorph showOnlySource: true ].
			diffMorph ]