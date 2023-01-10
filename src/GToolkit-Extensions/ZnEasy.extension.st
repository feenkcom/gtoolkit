Extension { #name : #ZnEasy }

{ #category : #'*GToolkit-Extensions' }
ZnEasy class >> gtGetImageOfType: mimeType fromUrl: urlObject [
	| client readStream pictureBytes |
	(client := self client)
		url: urlObject;
		accept: mimeType;
		enforceHttpSuccess: true;
		enforceAcceptContentType: true;
		get.
	
	readStream := client entity readStream.
	pictureBytes := readStream upToEnd.
	readStream close.
	
	"We create a SkiaImage and use it to get the form."
	^ (SkiaImage 
		fromBuffer: pictureBytes 
		start: 0 
		end: pictureBytes size - 1) asForm
]

{ #category : #'*GToolkit-Extensions' }
ZnEasy class >> gtGetPng: urlObject [
	"Use SkiaImage to convert bytes to a Form to avoid possible parsing errors in PNGs images."
	
	"self getPng: 'http://pharo.org/files/pharo.png'."
	"(self getPng: 'http://chart.googleapis.com/chart?cht=tx&chl=',
		'a^2+b^2=c^2' urlEncoded) asMorph openInHand."
	
	^ self 
		gtGetImageOfType: ZnMimeType imagePng 
		fromUrl: urlObject
]
