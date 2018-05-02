testing
matchesFileExtension: extensionString 
	"Return true if the extension matches a specific mime type"
	^ self supportedExtensions anySatisfy: [ :eachString | 
			eachString = extensionString ]