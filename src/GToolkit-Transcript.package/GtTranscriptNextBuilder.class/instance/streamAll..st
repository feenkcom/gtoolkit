streaming
streamAll: aBlock
	| rememberedAdornmentStrategy rememberedStartPosition |
	rememberedAdornmentStrategy := adornmentStrategy.
	rememberedStartPosition := startPosition.
	aBlock value.
	adornmentStrategy := rememberedAdornmentStrategy.
	startPosition := rememberedStartPosition.
	self applyAttributes