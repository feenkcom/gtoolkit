gt-inspector-extension
gtPrintContentsStringOn: aStream 
	aStream 
			<< 'id: ' << self id asString << String cr
			<< 'nonce: ' << self nonce asString << String cr
			<< 'title: ' << self title asString << String cr
			<< 'description: ' << self description asString << String cr
			<< 'timestamp: ' << self timestamp asString << String cr << String cr
			<< 'attachments: ' << String cr.
		self attachments 
			do: [ :eachAttachment | 
				eachAttachment gtPrintContentsStringOn: aStream  ] 
			separatedBy: [ aStream << String cr << String cr ]