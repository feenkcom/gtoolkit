streaming
nextPutAll: aString with: aBlock
	| previewAttribute |

	self nextPutAll: aString.
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: aBlock.
	text 
		attributes: { previewAttribute }
		from: text size - aString size + 1
		to: text size