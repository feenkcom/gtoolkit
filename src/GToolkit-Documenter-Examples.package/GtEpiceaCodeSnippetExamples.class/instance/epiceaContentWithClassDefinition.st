class definition
epiceaContentWithClassDefinition
	<gtExample>
	<label: 'Epicea changes with a class definition'>
	^ 'OmEntry {
	#tags : {
		#prior : OmNullReference [  ],
		#self : OmReference [ ''1'' ]
	},
	#content : EpClassModification {
		#oldClass : RGClassDefinition {
			#annotations : IdentityDictionary {
				#superclassName : ''Object'',
				#traitCompositionSource : ''{}'',
				#definitionSource : ''Object subclass: #MyClassOne\r\tinstanceVariableNames: \''\''\r\tclassVariableNames: \''\''\r\tpoolDictionaries: \''\''\r\tcategory: \''MyTestingPackage\''''
			},
			#name : #MyClassOne,
			#methods : IdentityDictionary { },
			#protocols : Set [ ],
			#instanceVariables : OrderedCollection [ ],
			#metaClass : RGMetaclassDefinition {
				#annotations : IdentityDictionary {
					#traitCompositionSource : ''{}'',
					#definitionSource : ''MyClassOne class\r\tinstanceVariableNames: \''\''''
				},
				#name : #''MyClassOne class'',
				#methods : IdentityDictionary { },
				#protocols : Set [ ],
				#instanceVariables : OrderedCollection [ ],
				#baseClass : @6
			},
			#comment : RGCommentDefinition {
				#annotations : IdentityDictionary {
					#className : #MyClassOne,
					#isMetaSide : false
				},
				#parent : @6,
				#content : ''''
			},
			#classVariables : OrderedCollection [ ],
			#category : #MyTestingPackage,
			#package : #MyTestingPackage,
			#sharedPools : OrderedCollection [ ]
		},
		#newClass : RGClassDefinition {
			#annotations : IdentityDictionary {
				#superclassName : ''Object'',
				#traitCompositionSource : ''{}'',
				#definitionSource : ''Object subclass: #MyClassOne\r\tinstanceVariableNames: \''varOne\''\r\tclassVariableNames: \''\''\r\tpoolDictionaries: \''\''\r\tcategory: \''MyTestingPackage\''''
			},
			#name : #MyClassOne,
			#methods : IdentityDictionary { },
			#protocols : Set [ ],
			#instanceVariables : OrderedCollection [
				RGInstanceVariableDefinition {
					#annotations : IdentityDictionary {
						#className : #MyClassOne,
						#isMetaSide : false
					},
					#name : #varOne,
					#parent : @20
				}
			],
			#metaClass : RGMetaclassDefinition {
				#annotations : IdentityDictionary {
					#traitCompositionSource : ''{}'',
					#definitionSource : ''MyClassOne class\r\tinstanceVariableNames: \''\''''
				},
				#name : #''MyClassOne class'',
				#methods : IdentityDictionary { },
				#protocols : Set [ ],
				#instanceVariables : OrderedCollection [ ],
				#baseClass : @20
			},
			#comment : RGCommentDefinition {
				#annotations : IdentityDictionary {
					#className : #MyClassOne,
					#isMetaSide : false
				},
				#parent : @20,
				#content : ''''
			},
			#classVariables : OrderedCollection [ ],
			#category : #MyTestingPackage,
			#package : #MyTestingPackage,
			#sharedPools : OrderedCollection [ ]
		}
	}
}

'