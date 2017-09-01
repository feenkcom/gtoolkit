GT-Examples-UI
gtDisplayOn: aStream
	self label isEmptyOrNil 
		ifTrue: [ 
			aStream 
				print: self methodClass; 
				nextPutAll: ' >> '; 
				print: self selector ]
		ifFalse: [ 
			aStream nextPutAll: self label ].
		
	self gtDisplayValidityOn: aStream