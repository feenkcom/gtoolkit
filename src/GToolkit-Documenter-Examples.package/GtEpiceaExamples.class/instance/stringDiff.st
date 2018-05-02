diff
stringDiff
	<gtExample>
	<label: 'A way to do string diff'>
	^ String streamContents: [ :aStream |
			(PrettyTextDiffBuilder 
				from: (True >> #and:) sourceCode 
				to: (True >> #or:) sourceCode)
				patchSequenceDoIfMatch: [ :string | aStream space; space; nextPutAll: string; cr ]
				ifInsert: [ :string | aStream nextPutAll: '+ '; nextPutAll: string; cr ]
				ifRemove: [ :string | aStream nextPutAll: '- '; nextPutAll: string; cr ] ].