require './lib/graph'
require 'curses'
require 'byebug'

class Graph::Square < Graph
  include Curses
  attr_accessor :vertices

  def initialize(n: 3)
    super()

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

  def print_vertices(start: nil, speed: 20)
    # Curses::curs_set(0) #invisible cursor
    start ||= @vertices.first.first

    maxdist = breadth_first_search(start: start)

    @vertices.each { |arr| arr.each(&:reset) }

    graph_text = StringIO.new
    breadth_first_search(start: start) do |neighbor|
      graph_text.rewind
      vertices.size.times do |i|
        vertices.size.times do |j|
          graph_text.print(vertices[i][j].char(maxdist: maxdist))
        end
        graph_text.print("\n")
      end

      system('clear')
      print(graph_text.string)
      sleep (1/speed.to_f)
    end
  end
  # Curses::curs_set(1) #visible cursor
end
