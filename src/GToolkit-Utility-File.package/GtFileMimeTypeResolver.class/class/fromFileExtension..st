accessing
fromFileExtension: fileExtension
	<return: #GtFileMimeTypeResolver or: nil>
	self allSubclassesDo: [ :eachClass | 
		(eachClass matchesFileExtension: fileExtension) ifTrue: [ 
			^ eachClass mimeTypeForFileExtention: fileExtension ] ].
	^ nil