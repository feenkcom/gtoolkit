Extension { #name : #RPackage }

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
