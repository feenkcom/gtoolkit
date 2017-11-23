initialization
initialize
	super initialize.
	
	zoomLevel := 1.0.
	self fixed: zoomLevel.
	
	self addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key equal; build);
		action: [ self zoomIn ]).
	self addShortcut: (BlShortcut new
		combination: (BlKeyCombination builder meta; key: Key minus; build);
		action: [ self zoomOut ])