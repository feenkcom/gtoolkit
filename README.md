# Glamorous Toolkit (GT) [![Build Status](https://travis-ci.org/feenkcom/gtoolkit.svg?branch=master)](https://travis-ci.org/feenkcom/gtoolkit)
Glamorous Toolkit is the moldable integrated development environment. For Pharo. It is free and open-source under an MIT license.

More details about it can be found on the official website: https://gtoolkit.com. 

## Components

The current repository embodies the second generation of GT that is based on the [Bloc project](https://github.com/pharo-graphics/Bloc) and it is comprised of a set of distinct components. Currently these are:
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
- [Releaser](https://github.com/feenkcom/gtoolkit-releaser): the engine that allows us to manage and release deeply nested projects.



## How to load

You can load the whole code in Pharo 7.0 using the following snippet:

```
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit/src';
    load
] ensure: [ EpMonitor current enable ].
#GtWorld asClass openTour.
```

## License

See [LICENSE](LICENSE).
