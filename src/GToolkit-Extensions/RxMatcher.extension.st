Extension { #name : #RxMatcher }

{ #category : #'*GToolkit-Extensions' }
RxMatcher >> gtSubexpressionsFor: aView [

	<gtView>
	| anInput anOutput |
	anInput := ValueHolder new contents: 'insert a text' asRopedText.
	anOutput := ValueHolder new.

	^ aView columnedList
		  title: 'Subexpressions';
		  priority: 1;
		  items: [ 
			  anOutput contents
				  ifNotNil: [ :aCollection | aCollection ]
				  ifNil: [ 
					  stream
						  ifNotNil: [ 
							  Array streamContents: [ :aStream | 
									  1 to: self subexpressionCount do: [ :anIndex | 
											  | aResult |
											  aResult := self subexpressions: anIndex.
											  aResult do: [ :anExpression | 
													  aStream nextPut: anIndex -> anExpression ] ] ] ]
						  ifNil: [ #(  ) ] ] ];
		  column: 'Index' text: #key width: 60;
		  column: 'Expression' text: #value;
		  send: #value;
		  actionDropdownButtonIcon: BrGlamorousIcons play
		  tooltip: 'Match a string'
		  content: [ :aButton :aTab | 
			  | aLabel |
			  BrVerticalPane new
				  hExact: 300;
				  vFitContent;
				  padding: (BlInsets all: 10);
				  addChild: (aLabel := BrLabel new
						             fitContent;
						             aptitude:
							             (BrGlamorousLabelAptitude new foreground:
									              BrGlamorousColors disabledButtonTextColor);
						             text: 'Matches for:');
				  addChild: (BrEditor new
						   aptitude: BrGlamorousRegularEditorAptitude;
						   text: anInput contents;
						   in: [ :theEditor | 
							   theEditor editor
								   when: BrTextEditorModifiedEvent
								   do: [ :anEvent | 
									   | aString |
									   aString := anEvent text asString.
									   (self matches: aString)
										   ifTrue: [ 
											   aLabel text: 'Matches:'.
											   anOutput contents: nil ]
										   ifFalse: [ 
											   (self matchesIn: aString)
												   ifNotEmpty: [ :aCollection | 
													   aLabel text: 'Matches in:'.
													   anOutput contents:
															   (aCollection withIndexCollect: [ :aValue :anIndex | 
																	    anIndex -> aValue ]) ]
												   ifEmpty: [ aLabel text: 'Cannot match or search:' ] ].
									   aTab viewContentElement phlow update ] ];
						   hMatchParent;
						   vFitContentLimited) ];
		  actionUpdateButton
]
