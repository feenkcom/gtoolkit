ring definition
classDefinitionFromString: aString
	"Extract a class name, e.g., MyClass and return a class definition"
	<return: #RGClassDefinition>
	| aDefinition |
	self 
		assert: [ aString isString ] 
		description: [ 'Class definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Class definition name has to be a non-empty string' ].
		
	aDefinition := (RGClassDefinition named: aString).
	^ aDefinition isDefined
		ifTrue: [ aDefinition realClass asRingDefinition ] 
		ifFalse: [ aDefinition ]