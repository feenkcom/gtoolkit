gt-inspector-extension
gtPrintContentsString
	^ String streamContents: [ :aStream | 
		self gtPrintContentsStringOn: aStream ]