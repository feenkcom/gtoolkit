*GToolkit-Transcript
transcriptMenuCommandOn: aBuilder
	<worldMenu>

	(aBuilder item: #'5. Transcript API')
		order: 0.5;
		iconName: #catalogIcon;
		parent: #'Moldable Editor';
		action: [ BlUniverse reset.
			(GTPlayground openContents: '''./pharo-local/iceberg/feenkcom/gtoolkit/doc/transcript/index.pillar'' asFileReference' label: 'Pillar')
				extent: 900@600 ].
		
	(aBuilder item: #'6. Transcript - Object shower')
		order: 0.6;
		iconName: #catalogIcon;
		parent: #'Moldable Editor';
		action: [ BlUniverse reset.
			(Smalltalk tools inspector openOn: (GtTranscriptExamples new objectShower)) extent: 400@600 ].
		
	(aBuilder item: #'7. Transcript - Element animation')
		order: 0.7;
		iconName: #catalogIcon;
		parent: #'Moldable Editor';
		action: [ BlUniverse reset.
			(Smalltalk tools inspector openOn: (GtTranscriptExamples new transcriptWitAnimation)) extent: 400@600 ].