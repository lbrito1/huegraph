require 'chroma'

class Vertex
  attr_accessor :id, :label, :marked, :dist, :i, :j
  alias :to_s :label
  alias :id :object_id

  def self.set_maxdist(maxdist)
    @@maxdist = maxdist
  end

  def self.set_hue(hue)
    @@hue = hue
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

  # TODO refactor
  def xterm_color
    color_width = 100 # TODO extract
    step = color_width/@@maxdist.to_f
    intensity = ((step * dist) + @@hue) % 255
    if dist == 0
      rgb_to_xterm(50,50,50)
    else
      col = Chroma.paint("hsl(#{intensity}, 100%, 65%)")
      rgb = col.rgb
      rgb_to_xterm(rgb.r, rgb.g, rgb.b)
    end
  end

  def reset
    @marked = false
    @dist = 0
  end

  # TODO refactor - got from https://codegolf.stackexchange.com/questions/156918/rgb-to-xterm-color-converter
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
