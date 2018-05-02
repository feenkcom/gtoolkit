public
mimeType
	"Return a given ZnMimeType object that represents the given file extension"
	<return: #ZnMimeType>
	^ ZnMimeType textPlain
		sub: 'pillar';
		yourself