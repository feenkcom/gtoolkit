Extension { #name : #String }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
String >> format: collection [
	"Format the receiver by interpolating elements from collection, as in the following examples:"
	"('Five is {1}.' format: { 1 + 4}) >>> 'Five is 5.'"
	"('Five is {five}.' format: (Dictionary with: #five -> 5)) >>>  'Five is 5.'"
	"('In {1} you can escape \{ by prefixing it with \\' format: {'strings'}) >>> 'In strings you can escape { by prefixing it with \' "
	"('In \{1\} you can escape \{ by prefixing it with \\' format: {'strings'}) >>> 'In {1} you can escape { by prefixing it with \' "
	"Placeholders are Strings; dictionaries are often keyed by Symbols: try the Symbol when the String key is absent"
	<gtPharoPatch: #StrictComparison>

	^ self species
		new: self size
		streamContents: [ :result |
			| stream |
			stream := self readStream.
			[ stream atEnd ]
				whileFalse: [ | currentChar |
					(currentChar := stream next) == ${
						ifTrue: [ | expression index |
							expression := stream upTo: $}.
							index := Integer readFrom: expression ifFail: [ expression ].
							result nextPutAll: ((collection isDictionary and: [ index isString ])
								ifTrue: [ collection at: index ifAbsent: [ collection at: index asSymbol ifAbsent: [ collection at: index ] ] ]
								ifFalse: [ collection at: index ]) asString ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]
