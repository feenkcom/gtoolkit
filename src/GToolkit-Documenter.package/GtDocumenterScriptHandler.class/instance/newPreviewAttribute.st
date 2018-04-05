instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ self newPreviewElement ]