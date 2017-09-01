private-init
initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample
	[ self providerFor: aCompiledMethod do: [ :aProvider | 
			(aProvider class canPerform: #gtExamplesSubjects) ifTrue: [
				self initializeSubjects: aProvider gtExamplesSubjects forExample: aGTExample ] ] ]
		on: Error
		do: [ :exception | 
			aGTExample addProblem: (GTExampleSubjectError new 
				example: aGTExample;
				signaledException: exception;
				yourself) ]