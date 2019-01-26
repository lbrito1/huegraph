require 'rainbow'

class Vertex
  attr_accessor :id, :label, :marked, :dist
  alias :to_s :label
  alias :id :object_id

  def marked?
    marked
  end

  def mark(dist: 0)
    @marked = true
    @dist = dist
  end

  def char(maxdist: 100)
    step = 255/maxdist.to_f
    this_intensity = step * dist
    Rainbow('■').color(this_intensity, 23, 98)
  end
end
