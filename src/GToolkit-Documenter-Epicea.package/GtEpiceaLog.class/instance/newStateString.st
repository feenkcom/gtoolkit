accessing
newStateString
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | entryItem |
				entryItem := EpEntryItem new entry: eachEntry.
				aStream nextPutAll: entryItem newStateString ]
			separatedBy: [ aStream cr; cr ] ]