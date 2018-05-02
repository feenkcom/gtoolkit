instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ :aBrText :aTextElement | 
			self newPreviewElementForText: aBrText inEditor: aTextElement ]