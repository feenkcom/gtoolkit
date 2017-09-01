public
value 
	self flag: 'Removed the context for now. Consider adding it back'.
	^ "self withContextDo: [" self process: self example "]"