Extension { #name : #Collection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Collection >> stringContentIntersection: aCollection [
	"Answer the set theoretic intersection of two collections.
	Compare Strings and Symbols based on their content."

	"(#(1 2 3 4) intersection: #(3 4 5)) >>> #(3 4)"

	"(#(1 2 3 4) intersection: #()) >>> #()"

	"(#() intersection: #(1 2 3 4)) >>> #()"

	"('hello' intersection: 'world') >>> 'ol'"

	^ self species withAll: (self asGtStringContentSet intersection: aCollection) asArray
]
