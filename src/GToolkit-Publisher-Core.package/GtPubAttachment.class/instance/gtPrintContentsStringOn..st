gt-inspector-extension
gtPrintContentsStringOn: aStream
	aStream 
		<< 'id: ' << self id asString << String cr
		<< 'fileName: ' << self fileName asString << String cr
		<< 'file size: ' << self fileSize asString << String cr
		<< 'url: ' << self url asString << String cr