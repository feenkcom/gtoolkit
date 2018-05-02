actions
executeCodeSnippet
	"Compiler evaluate: self codeSnippet" 
	"workspace := GtDocument new."
	nil class compiler
		source: self codeSnippet readStream;
		compilationContext: (CompilationContext new
			class: nil class;
			forSyntaxHighlighting: false;
			bindings: workspace;
			requestor: workspace);
		evaluate.