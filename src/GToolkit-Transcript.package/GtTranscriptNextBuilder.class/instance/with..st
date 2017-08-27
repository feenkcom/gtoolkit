streaming
with: aBlock
	| previewAttribute |
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: aBlock.
	attributes add: previewAttribute