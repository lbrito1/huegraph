require 'byebug'

# TODO adjacency x matrix
# TODO tests
# TODO print matrix
# TODO adjust id

class Graph
  attr_accessor :edges, :vertices

  def initialize
    @edges = {}
  end

  def square(n: 3)
    @vertices = []
    n.times do |i|
      @vertices[i] = []
      n.times do |j|
        @vertices[i] << Vertex.new.tap{ |v| v.label = "#{i},#{j}", v.x = i, v.y = j }
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
        print(vertices[i][j].char)
      end
      puts
    end
  end

  def add_edge(from:, to:, cost: 0)
    edges[from.id] ||= []
    edges[from.id] << Edge.new(from: from, to: to, cost: cost)
    edges[to.id] ||= []
    edges[to.id] << Edge.new(from: to, to: from, cost: cost) # TODO undirected
  end

  def neighbors(vertex:)
    edges[vertex.id]&.map(&:to) || []
  end

  def breadth_first_search(start:)
    q = [start]
    start.mark
    puts("Starting BFS on #{start}...")
    while(!q.empty?)
      v = q.delete_at(0)
      puts("  Visiting #{v.to_s}, vdist=#{v.dist}")
      neighbors = neighbors(vertex: v)
      puts("    Neighbors of #{v.to_s}: #{neighbors.map(&:to_s)}")
      neighbors.each do |neighbor|
        print("    Vertex #{neighbor.to_s}... ")
        if neighbor.marked?
          print("is already marked. \n")
        else
          print("marked now.\n")
          q << neighbor
          neighbor.mark(dist: v.dist + 1)
        end
      end
    end
  end
end

# class UndirectedMatrix < Graph
#   attr_accessor :vertices, :matrix

#   class << self
#     def square(n: 10)
#       label = ('a'.ord - 1).chr
#       vertices = n.times.map do
#         label = label.next
#         Vertex.new.tap { |v| v.label = label }
#       end
#       UndirectedMatrix.new(vertices: vertices)
#     end
#   end

#   def initialize(vertices:)
#     @vertices = vertices.each.with_index { |v, i| v.id = i }
#     @matrix = vertices.map { |row| vertices.map { false } }
#   end

#   def add_edge(from:, to:, costs: 0)
#     @matrix[from.id][to.id] = true
#   end

#   def neighbors(vertex:)
#     matrix[vertex.id]&.select(&:itself)&.map&.with_index { |_, i| vertices[i] }
#   end

#   def print_vertices
#     matrix.each do |row|
#       row.each do |col|
#         if col
#           print('+')
#         else
#           print('-')
#         end
#       end
#       print("\n")
#     end
#   end
# end
class Vertex
  attr_accessor :id, :x, :y, :label, :marked, :dist
  alias :to_s :label
  alias :id :object_id

  def marked?
    marked
  end

  def mark(dist: 0)
    @marked = true
    @dist = dist
  end

  def char
    dist.to_s.chars.first
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
  g.print_vertices
end


