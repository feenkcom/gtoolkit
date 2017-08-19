testing
isWeighted
	"Return true if I have a custom weight different from 1, false otherwise"
	<return: #Boolean>
	
	^ (self weight closeTo: 1.0) not