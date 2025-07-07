Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Class >> category: aString [
	<gtPharoPatch: #Pharo12>
	"Categorize the receiver under the system category, aString, removing it from
	any previous categorization."

	self 
		forPharo12: [
			| converter |
			self category = aString ifTrue: [ ^ self ].
 
			converter := CategoryConverter category: aString asSymbol.

			^ self package: converter packageName tag: converter tagName] 
		forPharo11AndPharo10: [
	
			| oldCategory |
			oldCategory := self basicCategory.
			aString isString
				ifTrue: [
					self basicCategory: aString asSymbol.
					self environment organization classify: self name under: self basicCategory ]
				ifFalse: [self errorCategoryName].
			SystemAnnouncer uniqueInstance
				class: self recategorizedFrom: oldCategory to: self basicCategory ]
]
