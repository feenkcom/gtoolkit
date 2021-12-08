Extension { #name : #String }

{ #category : #'*GToolkit-Extensions' }
String >> gtJSONFor: aView context: aContext [

	<gtView>
	self ifEmpty: [ ^ aView empty ].
	((self at: 1) = $[ or: [ (self at: 1) = ${ ]) ifFalse: [ 
		^ aView empty ].

	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].

	^ aView forward
		  title: 'JSON';
		  object: [ 
			  [ STONJSON fromString: self ]
				  on: Error
				  do: [ :anException | 
					  OrderedDictionary new
						  at: 'error' put: anException;
						  at: 'description' put: 'Could not parse';
						  yourself ] ];
		  view: #gtTreeFor:context:
]
