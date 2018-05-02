*GToolkit-Utility-File
gtPng: byteArray
	^ (self type: ZnMimeType imagePng length: byteArray size)
		bytes: byteArray;
		yourself 