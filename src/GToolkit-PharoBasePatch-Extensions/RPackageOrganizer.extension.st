Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer class >> default [
	"WARNING: Since this component can be changed (i.e. for testing) you should NOT use it directly.
	  Use RPackage class>>#organizer instead"

	^ self 
		forPharo12: [
			self class packageOrganizer ] 
		forPharo11AndPharo10: [
		 	default ifNil: [  default := self new ] ]
]
