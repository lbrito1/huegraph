require './lib/utils'

module Search
  def breadth_first_search(start:)
    q = [start]
    maxdist = 0
    start.mark
    dbg("Starting BFS on #{start}...\n")
    while(!q.empty?)
      v = q.delete_at(0)
      dbg("  Visiting #{v.to_s}, vdist=#{v.dist}\n")
      neighbors = neighbors(vertex: v)
      dbg("    Neighbors of #{v.to_s}: #{neighbors.map(&:to_s)}\n")
      neighbors.each do |neighbor|
        dbg("    Vertex #{neighbor.to_s}... ")
        if neighbor.marked?
          dbg("is already marked. \n")
        else
          dbg("marked now.\n")
          q << neighbor
          neighbor.mark(dist: v.dist + 1)
          maxdist = [v.dist + 1, maxdist].max
          yield(vertex: neighbor) if block_given?
        end
      end
    end

    maxdist
  end
end
