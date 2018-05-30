initialization
initialize
	super initialize.

	self icon: GtPillarPlayButtonIconStencil new.
	self label: 'Run'.
	self action: [ self inform: 'Executed' ]