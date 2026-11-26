Extension { #name : #IceGitHubError }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceGitHubError >> customError: aDictionary [
	"The JSON contents have String keys (STON fromString:)"
	<gtPharoPatch: #StrictComparison>
	^ aDictionary at: 'message'
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceGitHubError >> errorToString: aDictionary [
	"The JSON contents have String keys (STON fromString:)"
	<gtPharoPatch: #StrictComparison>
	(aDictionary at: 'code') = 'custom' ifTrue: [ ^ self customError: aDictionary ].
	(aDictionary at: 'code') = 'invalid' ifTrue: [ ^ self invalidError: aDictionary ].
	
	^ self unknownError: aDictionary	
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceGitHubError >> invalidError: aDictionary [
	"The JSON contents have String keys (STON fromString:)"
	<gtPharoPatch: #StrictComparison>
	^ 'Invalid field: ', (aDictionary at: 'field')
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceGitHubError >> messageBody [
	"The JSON contents have String keys (STON fromString:)"
	<gtPharoPatch: #StrictComparison>
	| errors |
	errors := self jsonContents at: 'errors' ifAbsent: [ ^ '' ].
	^ String streamContents: [ :stream | 
		errors
			do: [ :each | stream << (self errorToString: each) ] 
			separatedBy: [ stream cr ] ].
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceGitHubError >> messageText [
	"The JSON contents have String keys (STON fromString:)"
	<gtPharoPatch: #StrictComparison>
	^ self jsonContents at: 'message'
]
