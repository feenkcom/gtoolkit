accessing
sourceDirectory
	"Return parent directory of a source file"
	<return: #FileReference>
	self 
		assert: [ self sourceFileReference notNil ]
		description: [ 'Pillar source file has to be initialized first' ].
	^ self sourceFileReference parent