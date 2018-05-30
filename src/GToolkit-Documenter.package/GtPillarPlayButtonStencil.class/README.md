I create a play button

Example:

[[[
	(GtPillarPlayButtonStencil new
		icon: GtPillarPlayButtonIconStencil new;
		label: 'Play';
		action: [ self inform: 'Clicked' ]) asElement
]]]