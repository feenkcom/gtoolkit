*GToolkit-Documenter-Examples
withoutSourceCodeAndWithPrintInFigure
	<gtExample>
	<label: 'Output without a source code gtPrinIn: Figure output'>
	| instance |
	instance := self withSourceCodeAndPrintInFigure.
	instance parameters at: 'noCode' put: 'true'.
	self assert: instance noCode.
	^ instance