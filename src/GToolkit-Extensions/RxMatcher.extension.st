Extension { #name : #RxMatcher }

{ #category : #'*GToolkit-Extensions' }
RxMatcher >> gtSubexpressionsFor: aView [

	<gtView>
	| anInput |
	anInput := ValueHolder new contents: 'insert a text' asRopedText.

	^ aView columnedList
		  title: 'Subexpressions';
		  priority: 1;
		  items: [ 
			  stream
				  ifNotNil: [ 
					  Array streamContents: [ :aStream | 
							  1 to: self subexpressionCount do: [ :anIndex | 
									  | aResult |
									  aResult := self subexpressions: anIndex.
									  aResult do: [ :anExpression | 
											  aStream nextPut: anIndex -> anExpression ] ] ] ]
				  ifNil: [ #(  ) ] ];
		  column: 'Index' text: #key width: 60;
		  column: 'Expression' text: #value;
		  send: #value;
		  actionDropdownButtonIcon: BrGlamorousIcons play
		  tooltip: 'Evaluate string'
		  content: [ :aButton :aTab | 
			  BrVerticalPane new
				  hExact: 300;
				  vFitContent;
				  padding: (BlInsets all: 10);
				  addChild: (BrEditor new
						   aptitude: BrGlamorousRegularEditorAptitude;
						   text: anInput contents;
						   in: [ :theEditor | 
							   theEditor editor
								   when: BrTextEditorModifiedEvent
								   do: [ :anEvent | 
									   self matches: anEvent text asString.
									   aTab viewContentElement phlow update ] ];
						   hMatchParent;
						   vFitContentLimited) ];
		  actionUpdateButton
]
