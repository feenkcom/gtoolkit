protocol
executeWithStrategy: aGtBindingStrategy
	| newValue |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].

	aGtBindingStrategy bindings: self.
	newValue := self documentClass compiler
		source: self sourceCode readStream;
		compilationContext: (CompilationContext new
			class: self documentClass class;
			forSyntaxHighlighting: false;
			bindings: aGtBindingStrategy;
			requestor: aGtBindingStrategy);
		evaluate.
	self value: newValue.