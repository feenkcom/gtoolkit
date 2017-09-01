private - creating examples
initializeExample: aGTExample fromMethod: aCompiledMethod
	self initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample.
	self initializePragmasFromMethod: aCompiledMethod forExample: aGTExample.
