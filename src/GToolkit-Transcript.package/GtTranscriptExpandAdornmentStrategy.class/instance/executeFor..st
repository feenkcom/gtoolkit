executing
executeFor: transcriptNextState
	| previewAttribute |
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: self previewBlock.
	transcriptNextState transcript text 
		attributes: { previewAttribute }
		from: transcriptNextState startPosition
		to: transcriptNextState transcript text size