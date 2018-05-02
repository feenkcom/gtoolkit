source files
epiceaStepTwoContent
	<gtExample>
	<label: 'Epicea changes for the step two'>
	^ 'OmEntry {
	#tags : {
		#prior : OmNullReference [  ],
		#self : OmReference [ ''1'' ]
	},
	#content : EpMethodAddition {
		#method : RGMethodDefinition {
			#annotations : IdentityDictionary {
				#className : #MyClassOne,
				#isMetaSide : false
			},
			#name : #varOne,
			#protocol : #accessing,
			#sourceCode : ''varOne\r\t^ varOne'',
			#stamp : ''JurajKubelka 4/8/2018 12:02'',
			#package : #MyTestingPackage
		}
	}
}

OmEntry {
	#tags : {
		#prior : OmReference [ ''1'' ],
		#self : OmReference [ ''2'' ]
	},
	#content : EpMethodAddition {
		#method : RGMethodDefinition {
			#annotations : IdentityDictionary {
				#className : #MyClassOne,
				#isMetaSide : false
			},
			#name : #''varOne:'',
			#protocol : #accessing,
			#sourceCode : ''varOne: anObject\r\tvarOne := anObject'',
			#stamp : ''JurajKubelka 4/8/2018 12:02'',
			#package : #MyTestingPackage
		}
	}
}'