actions
executeCodeSnippet
	"Compiler evaluate: self codeSnippet" 
	"workspace := GtDocument new."
	| bindingStrategy result |
	bindingStrategy := GtPlaygroundBindingStrategy bindings: workspace.
	result := nil class compiler
		source: self codeSnippet readStream;
		compilationContext: (CompilationContext new
			class: nil class;
			forSyntaxHighlighting: false;
			bindings: bindingStrategy;
			requestor: bindingStrategy);
		evaluate.
	workspace value: result.
	editor editor styleText.