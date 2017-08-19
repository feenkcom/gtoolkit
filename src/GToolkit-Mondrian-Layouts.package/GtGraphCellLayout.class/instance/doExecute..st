hook
doExecute: elements 
	
	| lineItemSize pointer columnCount rowCount maxHeight columnsWidths rowHeights |
	lineItemSize := self lineItemsCountBlock rtValue: elements.

	"We compute the size of the grid"
	columnCount := 1.
	rowCount := 1.
	maxHeight := 0.
	columnsWidths := OrderedCollection new.
	rowHeights := OrderedCollection new.
	elements do: [ :e |
		columnsWidths size < columnCount ifTrue: [ columnsWidths add: 0 ].
		columnsWidths at: columnCount put: ((columnsWidths at: columnCount) max: e extent x).		
		maxHeight := maxHeight max: e extent y.
		columnCount := columnCount + 1.
		
		columnCount > lineItemSize
			ifTrue: [ 
				columnCount := 1. 
				rowHeights add: maxHeight.
				maxHeight := 0 ]
	].
	rowHeights add: maxHeight.


	"We do the translation"
	columnCount := 1.
	rowCount := 1.
	pointer := (((columnsWidths at: 1) / 2) @ ((rowHeights at: 1) / 2)).
	elements do: [ :e | 
		e translateTo: pointer.
		pointer := pointer + (self gapSize * 2 @ 0) + (((columnsWidths at: columnCount) / 2) @ 0).

		columnCount := columnCount + 1.
		columnCount > lineItemSize
			ifTrue: [ 
				columnCount := 1.
				pointer := (((columnsWidths at: 1) / 2) @ pointer y)  + (0 @ ((rowHeights at: rowCount) / 2)).
				rowCount := rowCount + 1.
				rowCount <= rowHeights size 
					ifTrue: [ pointer := pointer + (0 @ ((rowHeights at: rowCount) / 2)) ].				 
				 ]
			ifFalse: [ pointer := pointer + (self gapSize * 2 @ 0) + (((columnsWidths at: columnCount ) / 2) @ 0) ].
	]