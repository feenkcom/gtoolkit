*GToolkit-Documenter-Epicea
xdEquals: anEpEvent
	^ (super xdEquals: anEpEvent) and: [ 
		self methodAdded = anEpEvent methodAdded ]