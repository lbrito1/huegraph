#!/usr/bin/env ruby

require './lib/square'
g = Graph::Square.new(n: 20)

g.add_hori_barrier(i: 2, j: 0, size: 18)
g.add_hori_barrier(i: 6, j: 5, size: 15)
g.add_hori_barrier(i: 10, j: 0, size: 18)
g.add_hori_barrier(i: 14, j: 5, size: 15)
g.add_vert_barrier(i: 14, j: 5, size: 5)

g.print_vertices(speed: 150)

