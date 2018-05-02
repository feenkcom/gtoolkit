actions
executeCodeSnippet
	"Compiler evaluate: self codeSnippet" 
	"workspace := GtDocument new."
	| bindingStrategy |
	bindingStrategy := GtPlaygroundBindingStrategy bindings: workspace.
	nil class compiler
		source: self codeSnippet readStream;
		compilationContext: (CompilationContext new
			class: nil class;
			forSyntaxHighlighting: false;
			bindings: bindingStrategy;
			requestor: bindingStrategy);
		evaluate.