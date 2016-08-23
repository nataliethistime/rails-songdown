
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class VerseBlockOpener
      def to_html
        "<div class='sd-verse-block'>"
      end
    end
  end
end
