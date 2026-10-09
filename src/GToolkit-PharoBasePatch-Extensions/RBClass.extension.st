Extension { #name : #RBClass }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBClass >> category [
	<gtPharoPatch: #Pharo>
	^ self tagName 
			ifNil: [ self packageName] 
			ifNotNil: [ :aTagName |
					(self packageName, '-', aTagName) asSymbol ] 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBClass >> category: aSymbol [
	<gtPharoPatch: #Pharo12>
	
	| converter |
	converter := CategoryConverter 
		category: aSymbol environment: self class environment.
	self packageName: converter packageName.
	self tagName: converter tagName
]
