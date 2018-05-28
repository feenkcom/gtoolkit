initialization
initialize
	super initialize.

	self zoomLevel: 1.
	
	self addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key equal; build);
		action: [ self zoomIn ]).
	self addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key minus; build);
		action: [ self zoomOut ])