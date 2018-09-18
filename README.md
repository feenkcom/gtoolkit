# The Glamorous Toolkit (GT)
GT is the moldable IDE for Pharo. The main goal of GT is to redefine the experience of developing software.

The current repository embodies the second generation of GT that is based on the [Bloc project](https://github.com/pharo-graphics/Bloc) and it is comprised of a set of distinct tools. Currently these are:
- [Inspector](https://github.com/feenkcom/gtoolkit-inspector): the moldable inspector for Pharo on top of Bloc.
- [Playground](https://github.com/feenkcom/gtoolkit-playground): the moldable playground for Pharo on top of Bloc.
- [Documenter](https://github.com/feenkcom/gtoolkit-documenter): an engine for manipulating live documents in Pharo.
- [Debugger](https://github.com/feenkcom/gtoolkit-debugger): the moldable debugger for Pharo.
- [Coder](https://github.com/feenkcom/gtoolkit-coder): the moldable coder for Pharo.
- Transcript: a rethinking of the classic Transcript taking advantage of the moldable text editor from Bloc.
- [Visualizer](https://github.com/feenkcom/gtoolkit-visualizer): a set of visualization engines on top of Bloc.
- [Examples](https://github.com/feenkcom/gtoolkit-examples): an engine for example-driven development in Pharo.
- [Completer](https://github.com/feenkcom/gtoolkit-completer): the moldable completion engine.
- [Phlow](https://github.com/feenkcom/gtoolkit-phlow): the browsing engine.


## How to load

You can load the whole code in Pharo 6.1 using the following snippet:

```
Metacello new
   baseline: 'GToolkit';
   repository: 'github://feenkcom/gtoolkit/src';
   load.
#GtInspector asClass openOnPlayBook: (#GtDocumenter asClass editorForText: #BaselineOfGToolkit asClass comment).
```

## GT Documenter

<img src="https://github.com/feenkcom/gtoolkit-documenter/blob/master/doc/gt-documenter-snipper-preview-resize.gif" alt="Documenter: Documenter: Epicea diff" width="50%"/>

Learn more about [Documenter](https://github.com/feenkcom/gtoolkit-documenter).

## GT Transcript

Transcript offers a rich and interactable text interface for displaying live information coming from a system.

The API is backward compatible with the existing transcript. To enable the new features, we introduced a builder. For example, `transcript nextPutAll: 'something'` becomes `transcript next putAll: 'something'`, and after `next` we can add multiple attributes that we want to affect the following insertion of a text. The API can be seen in the following picture:

![Transcript: API](./doc/transcript-api.png)

To get an idea of how this tool can be useful, take a look at the following video showing the visual logging of a Bloc animation:

[![GT Transcript: logging an animation](https://img.youtube.com/vi/9VATYNaLwJY/0.jpg)](https://youtu.be/9VATYNaLwJY "GT Transcript: logging an animation")
