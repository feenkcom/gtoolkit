accessing
sourceFileReference: aFileReference
	self assert: [ aFileReference notNil ] description: [ 'Source file has to be initialized' ].
	self assert: [ aFileReference exists ] description: [ 'Source file has to exist' ].
	sourceFileReference := aFileReference