require 'utils'

module Search
  def breadth_first_search(start:)
    q = [start]
    maxdist = 0
    start.mark
    dbg("Starting BFS on #{start}...\n")
    while(!q.empty?)
      v = q.delete_at(0)
      dbg("  Visiting #{v.to_s}, vdist=#{v.dist}\n")
      neighbors = edges[v.id] || []
      dbg("    Neighbors of #{v.to_s}: #{neighbors.map(&:to_s)}\n")
      neighbors.each do |edge|
        v_neighbor = edge.to
        dbg("    Vertex #{v_neighbor.to_s}... ")
        if v_neighbor.marked?
          dbg("is already marked. \n")
        else
          dbg("marked now.\n")
          q << v_neighbor
          v_neighbor.mark(dist: v.dist + edge.cost)
          maxdist = [v.dist + edge.cost, maxdist].max
          yield(v_neighbor) if block_given?
        end
      end
    end

    maxdist
  end
end
