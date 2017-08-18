scripting - core
edges: aCollection from: aFromBlock to: aToBlock
	^ self edges
		connect: aCollection 
		from: aFromBlock 
		to: aToBlock 