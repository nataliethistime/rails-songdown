
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class VerseHeader < SongdownCompiler::Node
      def to_html
        @section.gsub!(
          SongdownCompiler::Tokens::VERSE_ANY_HEADER,
          SongdownCompiler::Tokens::VERSE_START
        )

        '<span class="verse-header">' + @section + '</span><br />'
      end
    end
  end
end
