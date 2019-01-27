require 'chroma'

class Vertex
  attr_accessor :id, :label, :marked, :dist, :i, :j
  alias :to_s :label
  alias :id :object_id

  def self.set_maxdist(maxdist)
    @@maxdist = maxdist
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

  def xterm_color
    step = 255/@@maxdist.to_f
    intensity = (step * dist)
    rgb = Chroma.paint("hsl(#{intensity}, 100%, 50%)").rgb
    rgb_to_xterm(rgb.r, rgb.g, rgb.b)
  end

  def reset
    @marked = false
    @dist = 0
  end

  def rgb_to_xterm(r,g,b)
    ->c{
      d=0,95,135,175,215,255                 # d is the set of possible RGB values
      a=(0..239).map{|n|                     # Create the array of Xterm triplets
        n<216 ? [d[n/36],d[(n%36)/6],d[n%6]] # Convert x from base 6 to base d, or
              : [n*10-2152]*3                #   create a uniform triplet
      }.map{|t|
        t.zip(c).map{|a,b|(a-b).abs}.sum     # Map from triplets to Manhattan distance
      }
      a.rindex(a.min) +                      # Find the last index of the lowest distance
      16                                     # Offset for the exluded system colors
    }.call([r,g,b])
  end
end
