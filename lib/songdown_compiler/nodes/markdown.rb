
require 'songdown_compiler/node'

require 'kramdown'

class SongdownCompiler
  class Nodes
    class Markdown < SongdownCompiler::Node
      def to_html
        Kramdown::Document.new(@section, input: 'markdown').to_html
      end
    end
  end
end
