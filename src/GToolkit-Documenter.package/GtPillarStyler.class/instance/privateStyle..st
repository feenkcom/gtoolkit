private
privateStyle: aText 
	GtPillarHighlightingParser new 
		fileReference: fileReference;
		targetText: aText;
		workspace: workspace;
		parse: aText asString.
	^ aText