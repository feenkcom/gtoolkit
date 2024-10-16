Extension { #name : #MetacelloProjectRegistry }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloProjectRegistry >> baselineRegistry [
    baselineRegistry ifNil: [ baselineRegistry := GtStringContentDictionary new ].
    ^ baselineRegistry
]
