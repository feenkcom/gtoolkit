examples
completeAPIOn: transcript
	<gtExample>
	<dependsOn: #transcript>
	transcript 
		nextPutAll: 'This is an example of';
		space;
		nextPutAll: 'the new GT Transcript';
		nextPut: '.';
		cr.
	transcript next
		putAll: 'Beside typical text, it can also handle:';
		cr.
	transcript next
		tab;
		color: Color blue;
		putAll: 'Colored text';
		cr.
	transcript tab.
	transcript next	
		fontSize: 16;
		putAll: 'Varying size text';
		cr.
	transcript next
		tab;
		expanding: [ BlElement new background: Color indexedColors atRandom; yourself ];
		putAll: 'Embelished with extra expansion';
		cr.
	transcript next 
		tab;
		italic;
		bold;
		streamAll: [ transcript next putAll: 'And others ...' ].
	^ transcript 