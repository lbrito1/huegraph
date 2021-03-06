require 'chroma'

module Colorizeable
  # TODO refactor
  def xterm_color
    step = self.class.color_width/self.class.max_dist.to_f
    intensity = ((step * dist) + self.class.hue) % 256
    if dist == 0
      rgb_to_xterm(50,50,50)
    else
      col = Chroma.paint("hsl(#{intensity}, 100%, 65%)")
      rgb = col.rgb
      rgb_to_xterm(rgb.r, rgb.g, rgb.b)
    end
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
