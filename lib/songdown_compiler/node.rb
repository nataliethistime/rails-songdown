
require 'songdown_compiler/tokens'

class SongdownCompiler
  class Node
    attr_accessor :content

    def initialize(input)
      @content = input
    end

    def to_html
      raise 'Override me!!'
    end
  end
end
