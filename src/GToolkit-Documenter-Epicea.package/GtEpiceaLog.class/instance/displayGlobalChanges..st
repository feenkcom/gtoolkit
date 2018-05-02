event handling
displayGlobalChanges: aBrButtonModel 
	aBrButtonModel widget fireEvent: (GLMBlocObjectToSelect new 
		toSelect: self)