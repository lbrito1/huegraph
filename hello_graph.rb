require './lib/square'
g = Graph::Square.new(n: 20)
10.times { |j| g.add_barrier(10, 5 + j) }
g.print_vertices

