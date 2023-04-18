Extension { #name : #AsyncStreamBuffer }

{ #category : #'*GToolkit-Extensions' }
AsyncStreamBuffer >> gtBufferedItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Buffered';
		priority: 5;
		items: [ bufferSink collection asArray ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Item' text: [ :anItem | anItem ];
		updateWhen: Announcement in: (announcer ifNil: [ announcer := Announcer new ]);
		actionUpdateButton
]
