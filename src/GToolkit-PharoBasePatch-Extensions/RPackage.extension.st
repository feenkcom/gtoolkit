Extension { #name : #RPackage }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> addClassTag: aSymbol [
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
RPackage class >> defaultPackageName [
	^ self 
		forPharo12: [ UndefinedPackage undefinedPackageName ] 
		forPharo11AndPharo10: [ #'_UnpackagedPackage' ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> packageName [
	<gtPharoPatch: #Pharo>
	
	"Exists to be polymorphic with packageName in the PackageTag"
	^ self name
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> tagNamed: aSymbol [
	<gtPharoPatch: #Pharo12>
	
	^ self 
		forPharo12: [ self tags detect: [ :each | each name = aSymbol ] ] 
		forPharo11AndPharo10: [ self classTagNamed: aSymbol  ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> tagNamed: aSymbol ifAbsent: aBlock [
	<gtPharoPatch:  #Pharo12>
	
	^ self tags
		  detect: [ :each | each name = aSymbol ]
		  ifNone: aBlock
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> tagOf: aClass [
	<gtPharoPatch: #Pharo>
	
	^ self forPharo12:[
		self tags
			detect: [ :tag | tag includesClass: aClass ]
			ifNone: [
				self error: ('No tag containing {1} found in package {2}' format: {
					aClass name.
					self name }) ]]
		forPharo11AndPharo10: [ self classTagForClass: aClass]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackage >> tagOrNilOf: aClass [
	^ self forPharo12:[
		self tags
			detect: [ :tag | tag includesClass: aClass ]
			ifNone: [ nil ]]
		forPharo11AndPharo10: [ self classTagForClass: aClass]
]
