geometry
groupBounds: aCollectionOfElements
	"Return encompassing bounds of a collection of elements"

	^ (aCollectionOfElements 
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (aCollectionOfElements collect: #measuredBounds) ])