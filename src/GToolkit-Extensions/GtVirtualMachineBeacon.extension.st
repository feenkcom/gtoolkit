Extension { #name : #GtVirtualMachineBeacon }

{ #category : #'*GToolkit-Extensions' }
GtVirtualMachineBeacon >> gtEnabledSignals: aView [
	<gtView>
	
	^ aView list
		priority: 2;
		title: 'Enabled signals';
		items: [ self enabledSignals ]
]
