gt-inspector-extension
gtPrintContentsStringOn: aStream
	self post 
		ifNil: [ self printOn: aStream ]
		ifNotNil: [ :aPost | aPost gtPrintContentsStringOn: aStream ]