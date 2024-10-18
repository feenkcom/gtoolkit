Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RPackageOrganizer >> packageMatchingExtensionName: anExtensionName [

	"return nil if no package is not found"
	| tmpPackageName |

	"we first look if their is a package matching exactly the name specified"
	(self packageExactlyMatchingExtensionName: anExtensionName)
		ifNotNil: [ :package | ^ package ].

	"if no package was found, we try to find one matching the begining of the name specified"
	tmpPackageName := ''.
	packages keysDo: [:aSymbol |
		(anExtensionName beginsWith: (aSymbol asString, '-') caseSensitive: false)
			ifTrue: [
				"we keep the longest package name found"
				(aSymbol size > tmpPackageName size)
					ifTrue: [ tmpPackageName := aSymbol ]]].

	^ tmpPackageName
		ifEmpty: [ nil ]
		ifNotEmpty: [ self packageNamed: tmpPackageName ]
]
