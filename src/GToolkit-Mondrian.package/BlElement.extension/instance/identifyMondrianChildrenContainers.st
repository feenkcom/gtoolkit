*GToolkit-Mondrian
identifyMondrianChildrenContainers
	| childrenContainers |
	childrenContainers := Dictionary new.
	self allChildrenBreadthFirstDo: [ :each | 
		each isMondrianChildrenContainer ifTrue: [ 
			childrenContainers at: each mondrianChildrenContainerName put: each ] ].
	childrenContainers isEmpty ifTrue: [ childrenContainers at: #default put: self ].
	self userData 
		at: #mondrianChildrenContainers
		put: childrenContainers