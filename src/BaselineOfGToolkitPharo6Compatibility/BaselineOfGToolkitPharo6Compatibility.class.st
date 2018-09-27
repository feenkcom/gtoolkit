Class {
	#name : #BaselineOfGToolkitPharo6Compatibility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPharo6Compatibility
}

{ #category : #baseline }
BaselineOfGToolkitPharo6Compatibility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			preLoadDoIt: #updateZincHTTPComponents:;
			project: 'ZincHTTPComponentsCharacterEncoding' with: [ 
				spec
					className: #ConfigurationOfZincHTTPComponents;
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/';
					versionString: #stable;
					loads: 'Character-Encoding' ];
			package: 'GToolkit-Pharo6Compatibility' with: [
				spec requires: #( 'ZincHTTPComponentsCharacterEncoding' ) ]
	]

]

{ #category : #private }
BaselineOfGToolkitPharo6Compatibility >> updateZincHTTPComponents: spec [
	Gofer it
		smalltalkhubUser: 'SvenVanCaekenberghe' project: 'ZincHTTPComponents';
		package: 'ConfigurationOfZincHTTPComponents';
		load
]
