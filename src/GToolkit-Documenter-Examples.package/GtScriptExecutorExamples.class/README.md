! Executable Pillar Scripts

!! Initial Example 

To experiment in this tutorial, first open a trascript:

[[[label=Open Transcript
Transcript open.
]]]

The following Pillar document includes two code snippets that we will use for experimenting:

[[[example=GtScriptExecutorExamples>>#pillarElementWithTwoCodeSnippets|noCode|showLive|height=300]]]

First, evaluate both code snippets. You should obtain a ==21== number in the trascript.

!! Inserting a Code Snippet

Now, try to insert another code snippet with ==out + 21== between two existing code snippets. You should obtain a document like this: 

[[[example=GtScriptExecutorExamples>>#insertScriptInTheMiddle|noCode|showLive|height=300]]]

You can notice that you do not need evaluate the first code snippet again. You have to evaluate the new one, following by the last one. The obtained value in the transcript should be ==42==.

!! Removing a Code Snippet

Now, try to remove the recently added code snippet. It is enought to remove one ==[== bracket character. If you evaluate the last code snippet, you will obtain again the value =21= in the transcript. Notice that it is not necessary to re-evaluate again the first code snippet. The editor rembers last values whenever possible.
 