ring definition
packageDefinitionFromString: aString
	"Extract a package name, e.g., MyPackage and return a package definition"
	<return: #RGPackage>
	self 
		assert: [ aString isString ] 
		description: [ 'Package definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Package definition name has to be a non-empty string' ].
	
	^ RGPackage named: aString asSymbol