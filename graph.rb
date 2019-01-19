require 'byebug'

# TODO adjacency x matrix
# TODO tests
# TODO print matrix
# TODO adjust id

class Graph


  attr_accessor :edges

  def initialize
    @edges = {}
  end

  def add_edge(from:, to:, cost: 0)
    edges[from.id] ||= []
    edges[from.id] << Edge.new(from: from, to: to, cost: cost)
    # edges[to.id] ||= []
    # edges[to.id] << Edge.new(from: to, to: from, cost: cost) # TODO undirected
  end

  def neighbors(vertex:)
    edges[vertex.id]&.map(&:to) || []
  end

  def breadth_first_search(start:)
    q = [start]
    start.mark
    puts("Starting BFS on #{start}...")
    while(!q.empty?)
      v = q.pop
      puts("  Visiting #{v}")
      neighbors = neighbors(vertex: v)
      puts("    Neighbors of #{v}: #{neighbors.map(&:to_s)}")
      neighbors.each do |neighbor|
        print("    Vertex #{neighbor}... ")
        if neighbor.marked?
          print("is already marked. \n")
        else
          print("marked now. \n")
          q << neighbor
          neighbor.mark
        end
      end
    end
  end
end

class UndirectedMatrix < Graph
  attr_accessor :vertices, :matrix

  class << self
    def square(n: 20)
      label = ('a'.ord - 1).chr
      vertices = n.times.map do
        label = label.next
        Vertex.new.tap { |v| v.label = label }
      end
      UndirectedMatrix.new(vertices: vertices)
    end
  end

  def initialize(vertices:)
    @vertices = vertices.each.with_index { |v, i| v.id = i }
    @matrix = vertices.map { |row| vertices.map { false } }
  end

  def add_edge(from:, to:, costs: 0)
    @matrix[from.id][to.id] = true
  end

  def neighbors(vertex:)
    matrix[vertex.id]&.select(&:itself)&.map&.with_index { |_, i| vertices[i] }
  end

  def print_edges
    matrix.each do |row|
      row.each do |col|
        if col
          print('+')
        else
          print('-')
        end
      end
      print("\n")
    end
  end
end
class Vertex
  attr_accessor :id, :x, :y, :label, :marked
  alias :to_s :label

  def marked?
    marked
  end

  def mark
    @marked = true
  end
end

class Edge
  attr_accessor :from, :to, :cost

  def initialize(from:, to:, cost:)
    @from = from
    @to = to
    @cost = cost
  end

  def to_s
    "Edge #{from} -> #{to} (costs #{cost})"
  end
end

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
  g.print_edges
end


