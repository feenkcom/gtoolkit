executing
executeOn: aString for: transcript
	| previewAttribute |

	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: self previewBlock.
	transcript text 
		attributes: { previewAttribute }
		from: transcript text size - aString size + 1
		to: transcript text size