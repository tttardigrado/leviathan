# leviathan

[![Package Version](https://img.shields.io/hexpm/v/leviathan)](https://hex.pm/packages/leviathan)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/leviathan/)

A simple library that implements the State Monad in Gleam!

## Example

```gleam
import leviathan as lv

fn tick() -> lv.State(s, Nil) {
  use x <- lv.do(lv.get())
  lv.put(x + 1)
}
```

## Installation

To add this library as a dependency to a gleam project run the following command:

```sh
gleam add leviathan
```

## Documentation

The auto-generated documentation can be founded [here](https://hexdocs.pm/leviathan)
