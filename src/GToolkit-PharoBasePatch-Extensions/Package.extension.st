Extension { #name : #Package }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> addClassTag: aSymbol [
	<gtPharoPatch: #Pharo12>
	"Add the class tag from the receiver, if already added do nothing."
	
	^ self 
		forPharo12AndNewer: [
			| tagName |
			"self toTagName: aSymbol"
			tagName := (aSymbol beginsWith: self name asString, '-')
				ifTrue: [ (aSymbol allButFirst: self name size + 1) asSymbol ]
				ifFalse: [ aSymbol ].
			self ensureTag: tagName ] 
		forPharo11: [
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
Package class >> defaultPackageName [
	^ self 
		forPharo12AndNewer: [ UndefinedPackage undefinedPackageName ] 
		forPharo11: [ #'_UnpackagedPackage' ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package class >> named: aString [
	^ self 
		forPharo12AndNewer: [
			self new
				name: aString;
				yourself] 
		forPharo11: [
			RPackage named: aString ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> packageName [
	<gtPharoPatch: #Pharo>
	
	"Exists to be polymorphic with packageName in the PackageTag"
	^ self name
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Package >> tagOrNilOf: aClass [
	^ self forPharo12AndNewer:[
		self tags
			detect: [ :tag | tag includesClass: aClass ]
			ifNone: [ nil ]]
		forPharo11: [ self classTagForClass: aClass]
]
