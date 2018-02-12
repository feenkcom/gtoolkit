adding
mimePart: aZnMimePart 
	self mimeParts add: aZnMimePart.
	self root ifNil: [ self root: aZnMimePart fileName ].