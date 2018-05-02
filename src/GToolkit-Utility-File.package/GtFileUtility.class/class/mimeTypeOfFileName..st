accessing - mime type
mimeTypeOfFileName: fileNameString
	<return: #ZnMimeType>
	| fileExtension |
	fileExtension := ('.' split: fileNameString) last.
	^ self mimeTypeOfExtension: fileExtension