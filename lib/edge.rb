class Edge
  attr_accessor :from, :to, :cost

  def to_s
    "Edge #{from} -> #{to} (costs #{cost})"
  end
end
