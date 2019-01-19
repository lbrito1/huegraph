require 'byebug'

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



  def breadth_first_search(start:)
    q = [start]
    start.mark
    puts("Starting BFS on #{start}...")
    while(!q.empty?)
      v = q.pop
      puts("  Visiting #{v}")
      neighboring_edges = edges[v.id]
      puts("    Edges of #{v}: #{neighboring_edges.map(&:to_s)}")
      neighboring_edges.each do |edge|
        neighbor = edge.to
        puts("    Vertex #{neighbor}")
        next if neighbor.marked?
        q << neighbor
        neighbor.mark
      end
    end
  end
end

class Vertex
  attr_accessor :x, :y, :label, :marked
  alias :id :object_id
  alias :to_s :label

  def marked?
    marked
  end

  def mark
    puts "Visited #{label}"
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


