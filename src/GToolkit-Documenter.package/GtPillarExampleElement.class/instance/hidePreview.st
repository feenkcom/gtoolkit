preview
hidePreview
	"Hide preview removing example element from its container"
	
	self
		assert: [ previewElement hasParent ]
		description: [ 'Can not hide preview if it is not shown' ].
	
	self
		assert: [ previewElement hasChildren ]
		description: [ 'Preview container must have example result element' ].
		
	self removeChild: previewElement.
	previewElement removeChildren