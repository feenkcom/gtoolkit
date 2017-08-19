reversing
verticallyReverse: elements
	"Vertically reverse the elements, as well as the attachpoints"
	| hauteur |
	
	hauteur := (self groupBounds: elements) height.
	elements
		do: [ :el | self translator translate: el to: el position x @ (hauteur - el position y) ]