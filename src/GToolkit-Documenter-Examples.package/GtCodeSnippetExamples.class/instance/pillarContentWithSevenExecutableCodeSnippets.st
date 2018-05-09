document
pillarContentWithSevenExecutableCodeSnippets
	<gtExample>
	<label: 'Pillar content with Epicea link'>
	^ '! This is en example of build-in executable code snippets

The first example opens a transcript:

[[[
Transcript open.
]]]

The second example writes to the transcript. Notice that ==variableTwo== is not initialized.

[[[label=Print
variableOne := 42.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
]]]

In the following script, we assign a value to ==variableTwo==. Notice that ==variableOne== have the same value as above as variableas are shared among the code snippets of the same document.

[[[label=Print
variableTwo := 72.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
Transcript show: ''variableThree = ''; show: variableThree; cr.
]]]

Now, let''s compute a factorial:

[[[label=Compute
4 factorial.
]]]

And let''s reference the result of the previous script here:

[[[label=Compute
out + 4.
]]]

==out== explicitly reference to a result of the previous code snippet. We can therefore print the previous result:

[[[label=Print
Transcript show: ''4 factorial + 4 = ''; show: out.
]]]

We can reference any code snippet result as presented in the following example:

[[[label=Close Transcript
(outs at: 1) delete.
]]]

'
