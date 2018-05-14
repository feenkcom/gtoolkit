instance creation
newExecuteCodeSnippetAttribute
	^ GtPillarInlinedTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ :aBrText :aTextElement | 
			self newExecuteCodeButtonForText: aBrText inEditor: aTextElement ]