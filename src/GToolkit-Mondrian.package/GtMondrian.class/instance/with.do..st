stack
with: aStep do: aBlock
	stack push: aStep.
	aBlock value.
	stack pop 