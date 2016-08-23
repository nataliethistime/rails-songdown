
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class LyricsLine < SongdownCompiler::Node
      def to_html
        Array(@content).map do |line|
          "<div class='sd-lyrics-line'>#{line}</div>"
        end
      end
    end
  end
end
