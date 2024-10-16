Extension { #name : #MetacelloAbstractPackageSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloAbstractPackageSpec >> specs: specNames forPackageOrdering: aVersionSpec [
  | packageOrProjectSpecs |
  packageOrProjectSpecs := GtStringContentSet new.
  specNames
    do: [ :specName | 
      | spec |
      "get project/group/package specs"
      spec := aVersionSpec
        packageNamed: specName
        ifAbsent: [ 
          MetacelloNameNotDefinedError
            signal:
              'project group, or package named: ' , specName printString
                ,
                  ' not found when used in requires: or includes: field of package: '
                , self name printString , ' for version: '
                , aVersionSpec versionString , ' of '
                , aVersionSpec projectLabel , '.'.
          nil	"return nil if resumed" ].
      spec
        ifNotNil: [ 
          packageOrProjectSpecs
            addAll: (spec resolveSpecsForPackageOrdering: aVersionSpec) ] ].
  ^ packageOrProjectSpecs
]
