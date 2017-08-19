A layout that packs rectangles in as amall space as possible (at least it tries to)

Instance Variables
	padding:	<Number>
	freeSpace:	<Set of Rectamgles>
	bounds:	<Point>

gap
	- gap between elements defined as "percentage" of average size. 0.2 means 20%

freeSpace
	- collection of spaces that can be used for next element insertion
	
bounds
	- bounding box of all currently processed elements
