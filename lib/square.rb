require './lib/graph'
require 'curses'
require 'byebug'

class Graph::Square < Graph
  attr_accessor :vertices

  def initialize(n: 3)
    super()

    Vertex.set_maxdist(n)

    @vertices = []
    n.times do |i|
      @vertices[i] = []
      n.times do |j|
        @vertices[i] << Vertex.new.tap { |v| v.label = "#{i},#{j}" }
      end
    end
    n.times do |i|
      n.times do |j|
        if j < n - 1
          add_edge(from: vertices[i][j], to: vertices[i][j+1])
        end
        if i < n - 1
          add_edge(from: vertices[i][j], to: vertices[i+1][j])
        end
      end
    end
  end

  def print_vertices(start: nil, speed: 100)
    Curses::curs_set(0) #invisible cursor
    Curses::init_screen
    Curses::start_color

    255.times.each { |i| Curses.init_pair(i,i, Curses::COLOR_BLACK) }

    start ||= @vertices.first.first

    @vertices.each { |arr| arr.each(&:reset) }

    # Record animation
    print 'Loading'
    slides = []
    nvert = vertices.size
    breadth_first_search(start: start) do |neighbor|
      slides << nvert.times.map do |i|
        nvert.times.map do |j|
          [vertices[i][j].char, vertices[i][j].xterm_color]
        end
      end
    end

    # Play animation
    slides.each do |vertices|
      vertices.size.times do |i|
        vertices.size.times do |j|
          Curses::setpos(i,j)
          char = vertices[i][j][0]
          color = vertices[i][j][1]
          Curses.attron(Curses::color_pair(color)|Curses::A_NORMAL) { Curses::addstr(char) }
        end
      end
      Curses::refresh

      sleep(1/speed.to_f)
    end

    Curses::curs_set(1) #visible cursor
  ensure
    Curses::close_screen
  end
end
