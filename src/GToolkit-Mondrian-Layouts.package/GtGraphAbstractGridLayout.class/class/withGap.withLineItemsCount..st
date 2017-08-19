instance creation
withGap: anInteger withLineItemsCount: aBlock
	
	^self new
		gapSize: anInteger;
		lineItemsCount: aBlock;
		yourself