require 'vertex'
require 'edge'
require 'search'

class Graph
  include Search

  attr_accessor :edges, :directed, :maxdist

  def initialize
    @edges = {}
  end

  def add_edge(from:, to:, cost: 1)
    edges[from.id] ||= []
    edges[from.id] << Edge.new.tap { |e| e.from = from, e.to = to, e.cost = cost }
    if !directed
      edges[to.id] ||= []
      edges[to.id] << Edge.new.tap { |e| e.from = to, e.to = from, e.cost = cost }
    end
  end
end
