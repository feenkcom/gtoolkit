Extension { #name : #Author }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Author class >> useAuthor: aString during: aBlock [
	^ self 
		fastForPharo13: [ 
			aBlock value] 
		forPharo12: [
			self uniqueInstance useAuthor: aString during: aBlock] 
		forPharo11: [
			self uniqueInstance useAuthor: aString during: aBlock]
]
