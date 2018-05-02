accessing - mime type
mimeTypeOfExtension: fileExtension
	<return: #ZnMimeType>
	| mime |
	mime := GtFileMimeTypeResolver fromFileExtension: fileExtension.
	mime ifNotNil: [ ^ mime ].
	mime := ZnMimeType
		forFilenameExtension: fileExtension
		ifAbsent: [ ZnMimeType default ].
	^ mime