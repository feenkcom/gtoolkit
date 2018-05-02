accessing
currentStateString
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | output |
				output := eachEntry content accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self theEnvironment).
				aStream nextPutAll: output ]
			separatedBy: [ aStream cr; cr ] ]