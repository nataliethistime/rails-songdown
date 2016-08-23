
require 'songdown_compiler/node'
require 'songdown_compiler/tokens'

class SongdownCompiler
  class Nodes
    class Goto < SongdownCompiler::Node
      def to_html
        goto_name = @content.gsub(SongdownCompiler::Tokens::GOTO, '').strip

        """
        <p>
          Play
          <span class='sd-goto'>#{goto_name}</span>
        </p>
        """
      end
    end
  end
end
