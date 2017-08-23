I am a utility class useful for scripting more complicated transcript instructions by cascading different options to be applied on the next string/character that is added to the transcript.

Please note that it is mandatory to end the cascade with either ==#put:-== or ==#putAll:==.

!!Example

[[[
	transcript next put: $a.
	transcript next 
		with: [ ... ];
		put: $b
]]]

