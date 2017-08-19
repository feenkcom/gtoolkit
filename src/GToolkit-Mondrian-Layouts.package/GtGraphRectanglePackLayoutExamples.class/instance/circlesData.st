private
circlesData
	^ GLMPresentation withAllSubclasses collect: [ :aClass | 
		aClass name  -> (30*( (aClass numberOfMethods max: 1) ln asInteger)) ]