
def testcase
  v1 = Vertex.new.tap {|v| v.x = 0; v.y = 0; v.label = 'A' }
  v2 = Vertex.new.tap {|v| v.x = 3; v.y = 2; v.label = 'B' }
  v3 = Vertex.new.tap {|v| v.x = 4; v.y = 6; v.label = 'C' }

  g = Graph.new()
  g.add_edge(from: v1, to: v2)
  g.add_edge(from: v2, to: v3)
  g.add_edge(from: v1, to: v3)

  g.breadth_first_search(start: v1)
end



def testcase2
  v1 = Vertex.new.tap {|v| v.x = 0; v.y = 0; v.label = 'A' }
  v2 = Vertex.new.tap {|v| v.x = 3; v.y = 2; v.label = 'B' }
  v3 = Vertex.new.tap {|v| v.x = 4; v.y = 6; v.label = 'C' }

  g = UndirectedMatrix.new(vertices: [v1, v2, v3])
  g.add_edge(from: v1, to: v2)
  g.add_edge(from: v2, to: v3)
  g.add_edge(from: v1, to: v3)

  g.breadth_first_search(start: v1)
  g.print_vertices
end

