private-init
initializeSubjects: aCollection forExample: aGTExample
	aCollection isEmptyOrNil ifTrue: [ ^ self ].
	
	aCollection do: [ :subject | 
		[ aGTExample addSubject: subject ]
			on:Error
			do: [ :exception | 
				aGTExample addProblem: (GTExampleSubjectError new 
					example: aGTExample;
					subject: subject;
					signaledException: exception;
					yourself) ] ] 