protocol - attachment
attachmentNamed: fileNameString bytes: aByteArray 
	self 
		attachmentNamed: fileNameString 
		entity: (ZnEntity bytes: aByteArray)