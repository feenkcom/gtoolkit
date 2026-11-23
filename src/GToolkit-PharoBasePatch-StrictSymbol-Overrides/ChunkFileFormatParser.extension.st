Extension { #name : #ChunkFileFormatParser }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ChunkFileFormatParser >> parseNextDeclaration [
	"OCParser class>>#parseLiterals: answers the keywords of a metadata chunk as Symbols"
	<gtPharoPatch: #StrictComparison>

	| isMetadata nextChunk |
	readStream skipSeparators.
	readStream isNextStyleChunk ifTrue: [
		self addDeclaration:
			(self styleChunkClass contents: readStream readUpToEndOfStyleChunk).
		^ self ].
	isMetadata := readStream isNextChunkMetaData.
	nextChunk := readStream next.
	isMetadata
		ifFalse: [
		self addDeclaration: (self doItChunkClass contents: nextChunk) ]
		ifTrue: [
			| substrings |
			substrings := OCParser parseLiterals: nextChunk.
			(substrings includes: self methodsForSelector asSymbol) ifTrue: [
				^ self parseMethodDeclarations: substrings ].
			(substrings includes: self commentStampSelector asSymbol) ifTrue: [
				^ self parseCommentDeclaration: substrings ].
			(substrings includes: self reorganizeSelector asSymbol) ifTrue: [
				^ self parseClassOrganization: substrings ] ]
]
