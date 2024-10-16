Extension { #name : #MetacelloPackagesSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloPackagesSpec >> sortPackageSpecs: orderedSpecs packageSpec: packageSpec groupLoops: groupLoops for: aVersionSpec [
	| packageIndex moved movePackage targetPackage targetIndex targetSpecNames groupLoopDetected |
	packageIndex := orderedSpecs indexOf: packageSpec.
	moved := movePackage := false.
	targetSpecNames := packageSpec
			requiredSpecNamesForPackageOrdering: aVersionSpec.
	groupLoopDetected := groupLoops includes: packageSpec.
	groupLoopDetected
		ifFalse: [ targetSpecNames
				do: [ :targetPackageOrProjectName | 
					targetPackage := orderedSpecs
							detect: [ :each | each name sameContentAs: targetPackageOrProjectName ]
							ifNone: [ MetacelloNameNotDefinedError
									signal: 'project group, or package named: ' , targetPackageOrProjectName printString
											, ' not found when used in requires: or includes: field of package: '
											, packageSpec name printString , ' for version: '
											, aVersionSpec versionString , ' of ' , aVersionSpec projectLabel
											, '.'.
								nil	"return nil if resumed" ].
					targetIndex := orderedSpecs indexOf: targetPackage.
					(groupLoopDetected not and: [ packageIndex = targetIndex ])
						ifTrue: [ self
								notify: 'A group loop has been detected. The package: ' , packageSpec name printString
										, ' requires a group that includes itself. If you resume, the group loop will be ignored and details will be written to the system log.'.
							groupLoopDetected := true.
							groupLoops add: packageSpec.
							MetacelloNotification signal: 'Package: ' , packageSpec name printString.
							MetacelloNotification signal: 'Raw Requires:' level: 2.
							packageSpec requires
								do: [ :each | MetacelloNotification signal: each asString level: 3 ].
							MetacelloNotification
								signal: 'Package: ' , packageSpec name printString , ' has a group loop:'.
							MetacelloNotification signal: 'Expanded Requires:' level: 2.
							targetSpecNames
								do: [ :each | MetacelloNotification signal: each asString level: 3 ] ].
					movePackage := movePackage or: [ packageIndex <= targetIndex ].
					false
						ifTrue: [  "use for debugging non-obvious reference loops"packageIndex < targetIndex
								ifTrue: [ MetacelloNotification
										signal: 'Moving ' , targetPackageOrProjectName , ' from ' , targetIndex printString
												, ' to ' , packageIndex printString ] ] ] ].
	groupLoopDetected
		ifTrue: [  "old implementation that does not resolve group names"targetSpecNames := packageSpec
					requires.
			targetSpecNames
				do: [ :targetPackageName | 
					targetPackage := orderedSpecs
							detect: [ :each | each name sameContentAs: targetPackageName ]
							ifNone: [  ].
					targetIndex := orderedSpecs indexOf: targetPackage.
					movePackage := movePackage or: [ packageIndex <= targetIndex ] ] ].
	movePackage
		ifTrue: [ moved := true.
			orderedSpecs
				remove: packageSpec
				ifAbsent: [ ^ self error: 'unexpected error removing package' ].
			targetIndex := 0.
			targetSpecNames
				do: [ :targetPackageOrProjectName | 
					(targetPackage := orderedSpecs
							detect: [ :each | each name sameContentAs: targetPackageOrProjectName ]
							ifNone: [  ]) ~~ nil
						ifTrue: [ targetIndex := targetIndex max: (orderedSpecs indexOf: targetPackage) ] ].
			targetIndex == 0
				ifTrue: [ orderedSpecs add: packageSpec beforeIndex: packageIndex ]
				ifFalse: [ orderedSpecs add: packageSpec afterIndex: targetIndex ] ].
	^ moved
]
