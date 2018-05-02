*GToolkit-Documenter-Epicea
xdEquals: anEpEvent
	^ (super xdEquals: anEpEvent) and: [ 
		self methodRemoved = anEpEvent methodRemoved ]