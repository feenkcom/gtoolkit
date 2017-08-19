public
on: aCollectionOfElements withGap: anInteger withLineItemsCount: aBlock
	"place the elements in a grid with (aBlock roValue: aCollectionOfElements) as the amount of elements horizontally"
	
	| myLayout |
	myLayout := self new gapSize: anInteger;  lineItemsCount: aBlock; yourself.
	myLayout applyOn: aCollectionOfElements.
	^ aCollectionOfElements