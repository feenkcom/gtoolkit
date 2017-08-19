private
childrenFor: aNode
	
	^self cachedChildren
		at: aNode
		ifAbsentPut:
			[| nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | 
					(edge fromElement == aNode and: [ edge toElement ~= aNode ])
						ifTrue:
							[(nodes includes: edge fromElement) ifFalse: [nodes add: edge toElement]]].
			nodes]