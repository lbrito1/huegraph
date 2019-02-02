# Huegraph

![](demo.gif)

Graphs with [hue](https://en.wikipedia.org/wiki/Hue).

## Installation

    $ gem install huegraph

## Usage

`huegraph` outputs the demo seen above. It is a 20x20 matrix-like graph. Each vertex is printed as a single character.

`huegraph hue=n` sets the hue to start at `n` degrees.

By default, the graph will render a total of 360 degrees of hue. When defining `hue=n`, we limit that to 100 degrees, so `huegraph hue=60` will use colors from 60 to 160 degrees. For more details check the Colorizeable module.

## Why?

Good question. This started as something to help me do some graph-related exercises, but then I found out about [Curses](https://github.com/ruby/curses) and was hooked.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lbrito1/huegraph.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
