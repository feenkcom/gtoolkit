# gtoolkit
The Glamorous Toolkit (GT) is the moldable IDE of Pharo.

The current repository embodies the second generation of GT that is based on the [Bloc project](https://github.com/pharo-graphics/Bloc) and it is comprised of a set of distinct tools. Currently these are:
- Documenter: a tool for showing live documentation inside Pharo. It is based on Pillar.
- Transcript: a rethinking of the classic Transcript taking advantage of the rich text editor from Bloc.
- Mondrian: a reimplementation of the graph-based visualization engine on top of Bloc.

## How to load

You can load the whole code in both Pharo 6.1 and in Pharo 7.0 using the following snippet:

```
Iceberg enableMetacelloIntegration: true.
Metacello new
   baseline: 'GToolkit';
   repository: 'github://feenkcom/gtoolkit/src';
   load.
```

Alternatively, you can also load each individual tools separately using the corresponding baselines.

## How tools look like

### Documenter

![Documenter: expanded pictures](./doc/documenter-mondrian-example-pictures.png)

[![GT Transcript: logging an animation](https://img.youtube.com/vi/9VATYNaLwJY/0.jpg)](https://youtu.be/9VATYNaLwJY "GT Transcript: logging an animation")
