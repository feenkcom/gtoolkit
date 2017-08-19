parsers
figure
	^ super figure 
	==> [ :tokens | 
		| attribute pictureFileReference fileNameWithoutPrefix |
				
		fileNameWithoutPrefix := tokens third.
		(fileNameWithoutPrefix beginsWith: 'file://') ifTrue: [ 
			fileNameWithoutPrefix := fileNameWithoutPrefix copyFrom: 'file://' size + 1 to: fileNameWithoutPrefix size ].
		pictureFileReference := self fileReference parent resolveString: fileNameWithoutPrefix.
		attribute := pictureFileReference exists
			ifTrue: [ 
				"make sure that file is a picture"
				(pictureFileReference isFile
					and: [ pictureFileReference mimeTypes notNil
						and: [ pictureFileReference mimeTypes first matches: ZnMimeType imagePng ] ])
					ifTrue: [
						| expandingAttribute attributesToAdd previewAttributeBlock previewAttribute |
						"we are doing a horrible hack here: we are creating the preview by hand if it needs to be expanded"
						previewAttributeBlock := [
							| anImageForm |
							anImageForm := pictureFileReference binaryReadStreamDo: [ :stream | 
								PNGReadWriter formFromStream: stream ].
							GtPillarPictureAttribute image: anImageForm ].
						expandingAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: previewAttributeBlock.
						attributesToAdd := OrderedCollection with: expandingAttribute.
						tokens fourth ifNotNil: [ :parameters | 
							(parameters anySatisfy: [:p | p first = 'expanded' asArray]) ifTrue: [ 
								previewAttribute := previewAttributeBlock value.
								expandingAttribute isExpanded: true; createdAttributes: { previewAttribute }.
								attributesToAdd add: previewAttribute ] ].
						self targetText 
							attributes: attributesToAdd
							from: tokens first start 
							to: tokens last stop ].
				self targetText 
					attributes: { BrTextForegroundAttribute paint: Color blue muchDarker }
					from: tokens first start 
					to: tokens last stop.
				]
			ifFalse: [ 
				self targetText 
					attributes: {  BrTextForegroundAttribute paint: Color red }
					from: tokens first start 
					to: tokens last stop.
				] ]