*GToolkit-Documenter-Epicea
xdEquals: anEpEvent
	^ (super xdEquals: anEpEvent) and: [ 
		self newMethod = anEpEvent newMethod and: [ 
			self oldMethod = anEpEvent oldMethod ] ]