hook
applyOn: elements
	"Return quickly if there is nothing to do"
	(elements isEmpty or: [ self isStopped ])
		ifTrue: [ ^ self ].
	self executeOnElements: elements