Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Extensions' }
GtExampleGroup >> buildListViewFor: aView [
	| aListView |
	aListView := aView columnedList
		title: 'Examples List';
		priority: 11;
		items: [ self examples sorted: GtMethodsSortFunction new ];
		column: '' translated do: [ :aColumn | 
			aColumn
				width: 24;
				cellStencil: [ 
					BlElement new
						size: 14@14;
						padding: (BlInsets top: 3 bottom: 3);
						margin: (BlInsets top: 3 bottom: 3);
						addAptitude: (GtPhlowLabelTooltipAptitude new 
							text: 'Click to run example');
						when: BlClickEvent
							do: [ :anEvent |
								anEvent currentTarget userData
									at: #example
									ifPresent: [ :anExample |
										anEvent consumed: true.
										[
										anExample run.
										anEvent currentTarget phlow 
											selectObject: anExample result returnValue ] asAsyncPromise ]
									ifAbsent: [ "do nothing" ] ] ];
			dataBinder: [ :aLabel :anExample :aRowIndex :aRowHolder :aCellIndex |
					| aHandler |
			
					aLabel userData 
						at: #exampleAnnouncementHandler_buildListViewFor_Status
						ifPresent: [ :anOldHandler | 
							aLabel userData
								at: #example
								ifPresent: [ :anOldExample | anOldExample announcer unsubscribe: anOldHandler ]
								ifAbsent: [ "do nothing" ] ]
						ifAbsent: [ "do nothing" ].
						
					aHandler := GtExampleColorHandler new element: aLabel.
					aLabel userData at: #exampleAnnouncementHandler_buildListViewFor_Status put: aHandler.	
						
					anExample announcer weak
						when: GtExampleExecuted
						send: #onAnnouncement:
						to: aHandler.
						
					aLabel background: anExample color.
					aLabel userData at: #example put: anExample ] ];
		column: 'Class' translated 
			text: [ :eachExample :anIndex | 
				eachExample example classLabel ];
		column: 'Selector' translated 
			text: [ :eachExample :anIndex | 
				eachExample example selector asString ];
		column: 'Result' translated do: [ :aColumn | 
			aColumn
				cellStencil: [
					BrLabel new
						aptitude: BrGlamorousListLabelAptitude;
						addAptitude: (GtPhlowLabelTooltipAptitude new 
							text: 'Click to display result details');
						fitContent;
						when: BlClickEvent
						do: [ :anEvent |
							anEvent currentTarget userData
								at: #example
								ifPresent: [ :anExample |
									anExample hasResult ifTrue: [ | aResult |
										aResult := anExample result returnValue.
										(aResult isKindOf: BlElement) ifTrue: [ 
											aResult removeFromParent ].
										anEvent currentTarget phlow spawnObject: aResult.
										anEvent consumed: true ] ]
								ifAbsent: [ "do nothing" ] ] ];
				dataBinder: [ :aLabel :anExample :aRowIndex :aRowHolder :aCellIndex |
					| aHandler |
					aLabel userData 
						at: #exampleAnnouncementHandler_buildListViewFor_Result 
						ifPresent: [ :anOldHandler |
							aLabel userData
								at: #example
								ifPresent: [ :anOldExample | anOldExample announcer unsubscribe: anOldHandler ]
								ifAbsent: [ "do nothing" ] ]
						ifAbsent: [ "do nothing" ].
					
					aHandler := GtExampleLabelTextHandler new element: aLabel.
					aLabel userData at: #exampleAnnouncementHandler_buildListViewFor_Result put: aHandler.	
											
					anExample announcer weak
						when: GtExampleExecuted
						send: #onAnnouncement:
						to: aHandler.
					
					aLabel text: anExample resultOrErrorName asRopedText.
					aLabel userData at: #example put: anExample ] ].
	^ aListView
]

{ #category : #'*GToolkit-Extensions' }
GtExampleGroup >> gtExamplesFor: aView [
	<gtView>
	^ aView explicit
		title: 'List';
		priority: 11;
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Run all examples'
			action: [ :aButton :aTab | 
				self runAllExamplesFrom: aButton.
				aTab viewContentElement phlow update ];
		actionUpdateButtonTooltip: 'Update example list';
		stencil: [ | aContainer aButtonsContainer aListView |
			aContainer := BlElement new
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 3).
					c horizontal matchParent.
					c vertical matchParent ].
			aButtonsContainer := BlElement new
				layout: (BlLinearLayout horizontal cellSpacing: 3);
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 3).
					c horizontal fitContent.
					c vertical fitContent.
					c linear horizontal alignCenter ].
			aContainer addChild: aButtonsContainer.
			aListView := self buildListViewFor: aView.
			aListView
				asElementDo: [ :anElement | 
					| aHandler aBuilder anUpdater |
					aBuilder := [  
						self buildButtonsContainer: aButtonsContainer listWidget: anElement ].
					anUpdater := BrElementUpdater new
						element: anElement;
						action: (MessageSend receiver: aBuilder selector: #value).

					aHandler := [ :anAnnouncement | anUpdater requestUpdate ].
					anElement userData at: #exampleAnnouncementHandler_gtExamplesFor put: aHandler.
										
					self announcer weak
						when: GtExamplesExecuted , GtExampleExecuted
						send: #value:
						to: aHandler.
					aContainer addChild: anElement.
					self
						buildButtonsContainer: aButtonsContainer
						listWidget: anElement ].
			aContainer ]
]
