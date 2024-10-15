Extension { #name : #Text }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Text >> sameContentAs: other [
	"Am I equal to the other Text or String?
	***** Warning ***** Two Texts are considered equal if they have the same characters in them.  They might have completely different emphasis, fonts, sizes, text actions, or embedded morphs.  If you need to find out if one is a true copy of the other, you must do (text1 = text2 and: [text1 runs = text2 runs])."

	other isText ifTrue:	["This is designed to run fast even for megabytes"
				^ string == other string or: [string = other string]].
	other isString ifTrue: [^ string == other or: [string sameContentAs: other]].
	^ false
]
