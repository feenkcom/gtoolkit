hook
doExecute: nodeElements 

	| root gap |
	"Not much to do if there is only one element"
	nodeElements size = 1 ifTrue: [ ^ self ].

	root := self rootNodesFor: nodeElements .
	root do: [ :e | self initializeNode: e ].
	root do: [ :e | self computePosition: e ].
	
	maxLayer := (root collect: [ :e | self layerOf: e ]) max.
	
	(root size > 1) ifTrue: [ maxLayer := maxLayer + 1 ].
	
	maxAbcissa := (self xOf: externalLayer last) + horizontalGap .
	
	gap := maxAbcissa "+ horizontalGap "/ 2 / Float pi / maxLayer.
	
	verticalGap := verticalGap max: gap.
	
	root do: [ :e | self draw: e. self step ].
	
	