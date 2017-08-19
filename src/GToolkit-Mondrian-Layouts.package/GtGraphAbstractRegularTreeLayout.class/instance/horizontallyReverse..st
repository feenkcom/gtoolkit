reversing
horizontallyReverse: elements
	"Horizontally reverse the elements, as well as the attachpoints"
	| largeur |
	
	largeur := (self groupBounds: elements) width.
	
	elements
		do: [ :el | self translator translate: el to: (largeur - el position x) @ el position y ]