Extension { #name : #RBClass }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBClass >> category [
	<gtPharoPatch: #Pharo>
	^ self 
		forPharo12AndNewer: [
			self tagName 
				ifNil: [ self packageName] 
				ifNotNil: [ :aTagName |
					(self packageName, '-', aTagName) asSymbol ] ] 
		forPharo11: [
			category
				ifNil: [ self isDefined
					ifTrue: [ category := self realClass category ]
					ifFalse: [ model environment
						whichCategoryIncludes: self name ] ]
				ifNotNil: [ category ]]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBClass >> category: aSymbol [
	<gtPharoPatch: #Pharo12>
	
	self 
		forPharo12AndNewer: [
			| converter |
			converter := CategoryConverter 
				category: aSymbol environment: self class environment.
			self packageName: converter packageName.
			self tagName: converter tagName] 
		forPharo11: [ category := aSymbol ]
]
