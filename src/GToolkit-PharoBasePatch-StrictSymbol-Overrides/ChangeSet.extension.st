Extension { #name : #ChangeSet }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ChangeSet >> clear [

	"Reset the receiver to be empty."

	changeRecords := GtStringContentDictionary new.
	preamble := nil.
	postscript := nil
]
