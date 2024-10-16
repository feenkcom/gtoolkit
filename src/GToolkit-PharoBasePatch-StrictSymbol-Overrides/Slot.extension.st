Extension { #name : #Slot }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Slot class >> isPseudovariableName: aSymbol [
	^ #(self true false nil thisContext super) includes: aSymbol
]
