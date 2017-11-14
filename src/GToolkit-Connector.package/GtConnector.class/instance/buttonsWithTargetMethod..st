search
buttonsWithTargetMethod: aMethod
	"Return a collection of buttons whose target is a given method"
	<return: #SequenceableCollection of: #BlElement>
	
	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			aChildElement userData
				at: #buttonAttributeTarget
				ifPresent: [ :aTarget |
					aTarget = aMethod
						ifTrue: [ aStream nextPut: aChildElement ] ] ] ]