protocol - attachment
attachmentNamed: fileNameString entity: aZnByteArrayEntity 
	self dataPost mimePart: (ZnMimePart 
			fieldName: fileNameString
			fileName: fileNameString 
			entity: aZnByteArrayEntity)