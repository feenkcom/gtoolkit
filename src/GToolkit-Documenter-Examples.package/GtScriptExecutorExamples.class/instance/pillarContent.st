source files
pillarContent
	<gtExample>
	<label: 'Pillar content with Epicea link'>
	^ '! This is en example of build-in Epicea change

The first example opens a transcript:

[[[
Transcript open.
]]]

The second example writes to the transcript:

[[[label=Print
variableOne := 42.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
]]]

Shared variable:

[[[label=Print
variableTwo := 72.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
Transcript show: ''variableThree = ''; show: variableThree; cr.
]]]

'
