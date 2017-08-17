instance creation
newArrowElement
	"Instantiate and return a new element playing a role of an arrow
	used to show / hide a preview"
	<return: #BlElement>

	^ BlElement new
		size: 24@24;
		geometry: (BlPolygon vertices: { 0@0 . 24@12 . 0@24 });
		margin: (BlInsets top: 0 right: 5 bottom: 0 left: 5);
		background: Color veryVeryLightGray