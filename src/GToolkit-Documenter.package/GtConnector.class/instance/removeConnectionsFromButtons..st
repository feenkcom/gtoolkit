private
removeConnectionsFromButtons: oldButtons
	(self children select: [ :each | each isKindOf: BlLineElement ]) do: [ :line |
		(oldButtons includes: line fromAnchor referenceElement) ifTrue: [ line removeFromParent ] ]