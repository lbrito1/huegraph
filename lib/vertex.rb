require './lib/colorizeable'

class Vertex
  include Colorizeable
  attr_accessor :id, :label, :marked, :dist, :i, :j
  alias :to_s :label
  alias :id :object_id

  @hue = 0
  @color_width = 255
  @maxdist = 1

  class << self
    attr_accessor :hue, :color_width, :max_dist
  end

  def marked?
    marked
  end

  def mark(dist: 0)
    @marked = true
    @dist = dist
  end

  def char
    dist.to_s.chars.last
  end

  def reset
    @marked = false
    @dist = 0
  end
end
