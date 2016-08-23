
require 'songdown_compiler/node'

require 'kramdown'

class SongdownCompiler
  class Nodes
    class Markdown < SongdownCompiler::Node
      def to_html
        document = Kramdown::Document.new(
          @content,
          :input => 'markdown',
          :auto_ids => false
        )

        document.to_html
      end
    end
  end
end
