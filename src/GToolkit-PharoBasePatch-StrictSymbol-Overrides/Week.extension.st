Extension { #name : #Week }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Week class >> indexOfDay: aSymbol [
	"The day names are Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>

	^ DayNames indexOf: (aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Week class >> startDay: aSymbol [
	"The day names are Symbols; callers pass Strings (the start day is kept as given)"
	<gtPharoPatch: #StrictComparison>

	(DayNames includes: (aSymbol isString ifTrue: [ aSymbol asSymbol ] ifFalse: [ aSymbol ]))
		ifTrue: [ StartDay := aSymbol ]
		ifFalse: [ self error: aSymbol, ' is not a recognised day name' ]
]
