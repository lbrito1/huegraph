require './lib/vertex'
require './lib/edge'
require './lib/search'

class Graph
  include Search

  attr_accessor :edges, :directed, :maxdist

  def initialize
    @edges = {}
  end

  def add_edge(from:, to:, cost: 0)
    edges[from.id] ||= []
    edges[from.id] << Edge.new.tap { |e| e.from = from, e.to = to, e.cost = cost }
    if !directed
      edges[to.id] ||= []
      edges[to.id] << Edge.new.tap { |e| e.from = to, e.to = from, e.cost = cost }
    end
  end

  def neighbors(vertex:)
    edges[vertex.id]&.map(&:to) || []
  end
end
