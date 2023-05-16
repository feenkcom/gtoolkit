Extension { #name : #SessionCategory }

{ #category : #'*GToolkit-Extensions' }
SessionCategory >> gtPrioritizedListWithPriority [
	^ priorityLists keys sorted 
		flatCollect: [ :index | (priorityLists at: index) 
			collect: [ :aSessionHandler |
				index -> aSessionHandler ] ]
]

{ #category : #'*GToolkit-Extensions' }
SessionCategory >> gtViewPrioritizedListFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Prioritized list';
		priority: 10;
		items: [ self gtPrioritizedListWithPriority ];
		column: 'Priority' text: [ :assoc | assoc key ] width: 100;
		column: 'Priority' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : #'*GToolkit-Extensions' }
SessionCategory >> gtViewPriorityListsFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Priority lists';
		object: [ (priorityLists associations sorted: [ :assoc |
			assoc key ] ascending) asOrderedDictionary ];
		priority: 20;
		view: #gtTreeFor:context:
]
