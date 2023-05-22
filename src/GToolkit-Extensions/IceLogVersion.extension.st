Extension { #name : #IceLogVersion }

{ #category : #'*GToolkit-Extensions' }
IceLogVersion >> gtViewTwoPanesDiffFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff (two panes)';
		priority: 19;
		stencil: [ 
			| aCompiledMethod aLocalSource |
			
			aCompiledMethod := self definition  compiledMethod.
			
			aLocalSource := String streamContents: [ :stream | 
		stream 
				<< '"protocol: ' << aCompiledMethod protocol << '"'; cr;
				<< aCompiledMethod sourceCode ].
		
		
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Repository:';
				toLabelText: 'Working Copy (local):';
				change: (GtDiffBuilder
					computeDifferencesFrom: self source
					to: aLocalSource
					using: GtSmaCCDiffSplitter forPharo);
				styler: GtPharoParser gtStyler ]
]
