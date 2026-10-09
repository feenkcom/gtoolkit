Extension { #name : #Package }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> addClassTag: aSymbol [
	"Add the class tag from the receiver, if already added do nothing."
	<gtPharoPatch: #Pharo12>
	| tagName |
	
	"self toTagName: aSymbol"
	tagName := (aSymbol beginsWith: self name asString , '-')
			ifTrue: [ (aSymbol allButFirst: self name size + 1) asSymbol ]
			ifFalse: [ aSymbol ].
	^ self ensureTag: tagName
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package class >> defaultPackageName [
	^ UndefinedPackage undefinedPackageName
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> isPharoPackageModel [
	^ true
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> packageName [
	<gtPharoPatch: #Pharo>
	
	"Exists to be polymorphic with packageName in the PackageTag"
	^ self name
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> tagOrNilOf: aClass [
	^ self tags
			detect: [ :tag | tag includesClass: aClass ]
			ifNone: [ nil ]
]
