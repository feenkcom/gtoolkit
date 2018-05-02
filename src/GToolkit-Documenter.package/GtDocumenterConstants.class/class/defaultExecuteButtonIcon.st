accessing - ui
defaultExecuteButtonIcon
	"Default label used for example for button labels, [[[label=Run]]]"
	^ BlElement new
		size: 8@10;
    	geometry: (BlPolygon vertices: { 0@0 . 8@5. 0@10 });
    	background: Color green muchDarker