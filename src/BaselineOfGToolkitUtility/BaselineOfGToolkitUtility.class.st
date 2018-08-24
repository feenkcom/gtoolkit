Class {
	#name : #BaselineOfGToolkitUtility,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGToolkitUtility'
}

{ #category : #baseline }
BaselineOfGToolkitUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			package: 'GToolkit-Utility-File';
			package: 'GToolkit-Utility-Assertion';
			package: 'GToolkit-Utility-Announcer';
			package: 'GToolkit-Utility-System' with: [
				spec requires: #( 'GToolkit-Utility-Assertion' ) ]
	]

]
