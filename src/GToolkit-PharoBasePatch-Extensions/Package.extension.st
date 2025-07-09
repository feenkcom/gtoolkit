Extension { #name : #Package }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> addClassTag: aSymbol [
	<gtPharoPatch: #Pharo12>
	"Add the class tag from the receiver, if already added do nothing."
	
	^ self 
		forPharo12: [
			| tagName |
			"self toTagName: aSymbol"
			tagName := (aSymbol beginsWith: self name asString, '-')
				ifTrue: [ (aSymbol allButFirst: self name size + 1) asSymbol ]
				ifFalse: [ aSymbol ].
			self ensureTag: tagName ] 
		forPharo11AndPharo10: [
			| tagName newTag |

			"strip package name if needed"
			tagName := self toTagName: aSymbol.

			self
				classTagNamed: tagName
				ifAbsent: [
					self class organizer
						validateCanBeAddedPackage: self
						tagName: tagName.
					newTag := self basicAddClassTag: tagName.
					SystemAnnouncer uniqueInstance classTagAdded: tagName inPackage: self.
					newTag] ].
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> packageName [
	<gtPharoPatch: #Pharo>
	
	"Exists to be polymorphic with packageName in the PackageTag"
	^ self name
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> tagOrNilOf: aClass [
	^ self forPharo12:[
		self tags
			detect: [ :tag | tag includesClass: aClass ]
			ifNone: [ nil ]]
		forPharo11AndPharo10: [ self classTagForClass: aClass]
]
