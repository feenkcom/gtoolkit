code snippet result
codeSnippetWithPlaygroundBindings
	<gtExample>
	<label: 'Code snippet with playground bindings'>
	| bindings playground |
	playground := self playgroundBindings.
	bindings := self codeSnippetResult.
	bindings bindings: playground.
	self assert: bindings bindings equals: playground.
	^ bindings