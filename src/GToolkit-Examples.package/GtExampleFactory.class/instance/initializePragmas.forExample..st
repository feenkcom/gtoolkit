private-init
initializePragmas: aCollection forExample: aGTExample
	aCollection do: [ :pragma | 
		(aGTExample class canPerform: pragma keyword) ifTrue: [ 
			[ aGTExample perform: pragma keyword withArguments: pragma arguments ]
				on:Error
				do:[ :exception | 
					aGTExample addProblem: (GTExamplePragmaError new 
						example: aGTExample;
						pragma: pragma;
						signaledException: exception;
						yourself) ] ] ]