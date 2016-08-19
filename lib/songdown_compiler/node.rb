
require 'songdown_compiler/tokens'

class SongdownCompiler
  class Node
    def initialize(input)
      @section = normalize_input input
    end

    def to_html
      raise 'Override me!!'
    end

    private
      def normalize_input(input)
        Array(input).join(SongdownCompiler::Tokens::NEWLINE).strip
      end
  end
end
