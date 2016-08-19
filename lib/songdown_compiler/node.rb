
require 'songdown_compiler/tokens'

class SongdownCompiler
  class Node
    def initialize(input)
      @section = input
    end

    def to_html
      raise 'Override me!!'
    end
  end
end
