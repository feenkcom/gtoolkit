Extension { #name : #CompiledMethod }

{ #category : #'*BaselineOfGToolkitPrerequisites' }
CompiledMethod >> sha256HashString [

	^ (SHA256 hashStream: self sourceCode withInternalLineEndings readStream) hex.
]
