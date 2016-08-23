
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class ChordsLine < SongdownCompiler::Node
      def to_html
        Array(@content).map do |line|
          "<div class='sd-chords-line'>#{line}</div>"
        end
      end
    end
  end
end
