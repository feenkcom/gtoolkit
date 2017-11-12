children hooks
removeConnectionsFromButtons: oldButtons
	(self children select: [ :each | each isKindOf: BlLineElement ]) do: [ :line |
		line fromAnchor referenceElement isAttachedToSceneGraph ifTrue: [ line removeFromParent ] ]