GT-Examples-UI
gtInspectorActionReturnValue
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :p | p selection: (self runThenDo: [ :r | r returnValue ] onErrorDo: [ :r | r ]) ];
		icon: (Smalltalk ui icons iconNamed: #glamorousGo);
		title: 'Evaluate and inspect return-value'