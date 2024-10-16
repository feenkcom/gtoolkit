Extension { #name : #MetacelloMemberListSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMemberListSpec >> map [
	
	| map |
	memberMap ~~ nil ifTrue: [ ^memberMap ].
	map := GtStringContentDictionary new.
	self list do: [:member | 
		member
			applyAdd: [:memberSpec | self mapAdd: memberSpec into: map ] 
			copy: [:memberSpec | self mapCopy: memberSpec into: map ]
			merge: [:memberSpec | self mapMerge: memberSpec into: map ] 
			remove: [:memberSpec | self mapRemove: memberSpec into: map ]].
	memberMap := map.
	^memberMap
]
