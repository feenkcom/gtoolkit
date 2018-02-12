gt-inspector-extension
gtPrintContentsStringOn: aStream
	super gtPrintContentsStringOn: aStream.
	aStream 
			<< 'root: ' << self root asString << String cr << String cr
			<< 'mime parts: ' << String cr.
		self mimeParts 
			do: [ :eachMimePart | 
				aStream 
					<< ' - fileName = ' << eachMimePart fileName asString
					<< ', type=' << eachMimePart contentType asString
					<< ', length=' << eachMimePart contentLength asString ] 
			separatedBy: [ aStream << String cr << String cr ]