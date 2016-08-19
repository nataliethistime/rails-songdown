
require 'songdown_compiler/node'
require 'songdown_compiler/tokens'

class SongdownCompiler
  class Nodes
    class Goto < SongdownCompiler::Node
      def to_html
        str = @section.gsub SongdownCompiler::Tokens::GOTO, 'Play'

        "<p>#{str}</p>"
      end
    end
  end
end
