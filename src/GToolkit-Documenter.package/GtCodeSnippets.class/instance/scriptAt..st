accessing
scriptAt: anInteger 
	^ collection at: anInteger ifAbsent: [ nil ]