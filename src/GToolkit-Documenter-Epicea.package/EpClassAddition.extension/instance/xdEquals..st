*GToolkit-Documenter-Epicea
xdEquals: anEpEvent
	^ (super xdEquals: anEpEvent) and: [ 
		self classAdded = anEpEvent classAdded ]