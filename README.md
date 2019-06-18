# Glamorous Toolkit (GT)
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
- [GToolkit4Smacc](https://github.com/feenkcom/gt4smacc): the environment for creating, debugging and testing SmaCC-based parsers.
- [GToolkit4PetitParser2](https://github.com/feenkcom/gt4petitparser2): the environment for creating, debugging and testing PetitParser2-based parsers.
- [GToolkit4Famix3](https://github.com/feenkcom/gt4famix3): the environment and dedicated algorithms that work with the Famix meta-model for source code analysis.



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
#GtWorld asClass open.
```

## How to load the latest development release

You can load the code we're working on in Pharo 7.0 using the following snippet:

```
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit:release/src';
    load
] ensure: [ EpMonitor current enable ].
#GtWorld asClass open.
```
## License

See [LICENSE](LICENSE).
