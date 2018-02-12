gt-inspector-extension
gtPrintContentsStringOn: aStream
	aStream 
			<< 'nonce: ' << self nonce asString << String cr
			<< 'title: ' << self title asString << String cr
			<< 'description: ' << self description asString << String cr
