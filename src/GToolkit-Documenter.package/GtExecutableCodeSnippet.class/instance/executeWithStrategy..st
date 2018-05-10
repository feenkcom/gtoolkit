protocol
executeWithStrategy: aGtBindingStrategy
	| newValue aCompiler |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].

	aGtBindingStrategy bindings: self.
	aCompiler := self documentClass compiler
		source: self sourceCode readStream;
		compilationContext: (CompilationContext new
			class: self documentClass class;
			forSyntaxHighlighting: false;
			bindings: aGtBindingStrategy;
			requestor: aGtBindingStrategy).
	[ 
		newValue := aCompiler evaluate.
		self value: newValue.
		announcer announce: (GtCodeSnippetSuccessfulExecutionAnnouncement document: self document codeSnippet: self newValue: newValue).
	] on: Error do: [ :anException | 
		announcer announce: (GtCodeSnippetFailedExecutionAnnouncement document: self document codeSnippet: self exception: anException).
	].
	