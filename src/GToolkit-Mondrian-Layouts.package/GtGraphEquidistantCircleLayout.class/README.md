RTEquidistantCircleLayout is a circle layout in which elements are equidistant from each other: the layout maintains the same distance between elements.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.
elements := (RTEllipse new size: 5; color: Color red; size: [:vv | vv * 4 ]) elementsOn: (1 to: 15).
v addAll: elements.
RTEquidistantCircleLayout on: elements.
v
-=-=-=-=-=-=-=-=-=-=-=-=