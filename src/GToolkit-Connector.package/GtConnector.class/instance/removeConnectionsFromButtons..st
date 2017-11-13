private
removeConnectionsFromButtons: oldButtons
	"(self children select: [ :each | each isKindOf: BlLineElement ]) do: [ :line |
		(oldButtons anySatisfy: [:oldButton | oldButton source = ((line fromAnchor referenceElement deep: #parent select: [ :each | each isKindOf: BrEditorElement ]) anyOne userData at: #editedMethod)]) ifTrue: [ line removeFromParent ] ]"