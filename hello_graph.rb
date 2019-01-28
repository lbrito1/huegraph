require './lib/square'
g = Graph::Square.new(n: 30)

g.add_hori_barrier(i: 2, j: 0, size: 25)
g.add_hori_barrier(i: 8, j: 5, size: 25)
g.add_hori_barrier(i: 12, j: 0, size: 25)
g.add_vert_barrier(i: 13, j: 23, size: 10)

g.print_vertices

