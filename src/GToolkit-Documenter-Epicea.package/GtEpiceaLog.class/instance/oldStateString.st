accessing
oldStateString
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | entryItem |
				entryItem := EpEntryItem new entry: eachEntry.
				aStream nextPutAll: entryItem oldStateString ]
			separatedBy: [ aStream cr; cr ] ]