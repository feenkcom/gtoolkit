hook
doInitialize: elements 
	super doInitialize: elements.
	self clear.
	self greedyCycleRemoval: elements