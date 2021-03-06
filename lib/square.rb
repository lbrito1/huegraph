require 'graph'
require 'curses'

class Graph::Square < Graph
  attr_accessor :vertices, :side

  def initialize(n: 3)
    super()

    @side = n

    @vertices = []
    n.times do |i|
      @vertices[i] = []
      n.times do |j|
        @vertices[i] << Vertex.new.tap { |v| v.label = "#{i},#{j}", v.i = i, v.j = j }
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

  def add_hori_barrier(i:, j:, size:)
    3.times do |offset_v|
      size.times do |offset_h|
        edges[vertices[i + offset_v][j + offset_h].id] = []
      end
    end
  end

  def add_vert_barrier(i:, j:, size:)
    3.times do |offset_h|
      size.times do |offset_v|
        edges[vertices[i + offset_v][j + offset_h].id] = []
      end
    end
  end

  def print_vertices(start: nil, speed: 300)
    Curses::curs_set(0) #invisible cursor
    Curses::init_screen
    Curses::start_color

    print 'Loading...'

    255.times.each { |i| Curses.init_pair(i,i, Curses::COLOR_BLACK) }

    start ||= @vertices.first.first

    # Get maxdist (needed for coloring)
    Vertex.max_dist = breadth_first_search(start: start)
    @vertices.each { |arr| arr.each(&:reset) }

    # Record animation
    first = nil
    slides = []
    nvert = vertices.size
    breadth_first_search(start: start) do |visited|
      first ||= nvert.times.map do |i|
        nvert.times.map do |j|
          [vertices[i][j].char, vertices[i][j].xterm_color]
        end
      end
      slides << [visited.i, visited.j, visited.char, visited.xterm_color]
    end

    # Play animation
    nvert.times do |i|
      nvert.times do |j|
        Curses::setpos(i,j)
        char = first[i][j][0]
        color = first[i][j][1]
        Curses.attron(Curses::color_pair(color)|Curses::A_NORMAL) { Curses::addstr(char) }
      end
    end
    slides.each do |vertex|
      i, j, char, color = vertex
      Curses::setpos(i, j)
      Curses.attron(Curses::color_pair(color)|Curses::A_NORMAL) { Curses::addstr(char) }
      sleep(1/speed.to_f)
      Curses::refresh
    end

    sleep(3)

    Curses::curs_set(1) #visible cursor
  ensure
    Curses::close_screen
  end
end
