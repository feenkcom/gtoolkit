I am a transcript that can handle both strings and adornments.

!Example

[[[
transcript := GTOTranscript new.
element := transcript newEditorElement.
transcript nextPutAll: 'test
asdasda'.
transcript nextPutAll: 'enhanced' with: [ BrTextAdornmentDynamicAttribute new beAppend; adornmentBlock: [ BlElement new size: 70 @ 50; background: Color red; yourself  ]].
transcript nextPutAll: 'test'.
element
]]]