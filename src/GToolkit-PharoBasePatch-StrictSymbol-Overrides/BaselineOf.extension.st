Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
BaselineOf class >> deepPackagesOfGroupNamed: aName [
	"Metacello group names are Strings; callers pass Symbols"
	<gtPharoPatch: #StrictComparison>
	"Traverses the group tree to collect packages"
	| allGroups projects group |

	allGroups := self version groups.
	projects := Array streamContents: [ :stream |
		self version spec
			specListProjectDo: [ :each | stream nextPut: each ] 
			packageDo: [ :each | ] 
			groupDo: [  :each | ] ].
	group := allGroups detect: [ :eachGroup | (eachGroup name isString and: [ aName isString ]) ifTrue: [ eachGroup name asString = aName asString ] ifFalse: [ eachGroup name = aName ] ].
	^ (group includes
		collect: [ :each | 
			(allGroups anySatisfy: [ :eachGroup | (eachGroup name isString and: [ each isString ]) ifTrue: [ eachGroup name asString = each asString ] ifFalse: [ eachGroup name = each ] ])
				ifTrue: [ self deepPackagesOfGroupNamed: each ]
				ifFalse: [
					(projects noneSatisfy: [ :eachProject | (eachProject name isString and: [ each isString ]) ifTrue: [ eachProject name asString = each asString ] ifFalse: [ eachProject name = each ] ]) 
						ifTrue: [ { each } ]
						ifFalse: [ #() ] ] ])
		flattened
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
BaselineOf class >> packagesOfGroupNamed: aName [
	"Metacello group names are Strings; callers pass Symbols"
	<gtPharoPatch: #StrictComparison>
	| aGroupName |
	aGroupName := aName asString.
	^ (self version groups detect: [ :g | g name asString = aGroupName ]) includes
]
