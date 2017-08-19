private
parentsFor: aNode
	^ self cachedParents
		at: aNode
		ifAbsentPut:
			[ | nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | edge toElement == aNode ifTrue: [ nodes add: edge fromElement ] ].
			nodes ]