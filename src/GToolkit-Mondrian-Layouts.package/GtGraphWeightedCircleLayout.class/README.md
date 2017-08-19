RTWeightedCircleLayout is a circle layout that gives more space to big elements and fewer space to small elements.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.
elements := (RTEllipse new size: 5; color: Color red; size: [:vv | vv * 4 ]) elementsOn: (1 to: 15).
v addAll: elements.
RTWeightedCircleLayout on: elements.
v
-=-=-=-=-=-=-=-=-=-=-=-=