Extension { #name : #RPackage }

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
