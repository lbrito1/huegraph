require './lib/graph'

class Graph::Square < Graph
  attr_accessor :vertices

  def initialize(n: 3)
    super()

    @vertices = []
    n.times do |i|
      @vertices[i] = []
      n.times do |j|
        @vertices[i] << Vertex.new.tap { |v| v.label = "#{i},#{j}" }
      end
    end
    n.times do |i|
      n.times do |j|
        if j < n - 1
          add_edge(from: vertices[i][j], to: vertices[i][j+1])
        end
        if i < n - 1
          add_edge(from: vertices[i][j], to: vertices[i+1][j])
        end
      end
    end
  end

  def print_vertices(start: nil)
    start ||= @vertices.first.first
    breadth_first_search(start: start)
    vertices.size.times do |i|
      vertices.size.times do |j|
        print(vertices[i][j].char(maxdist: maxdist))
      end
      puts
    end
  end
end
