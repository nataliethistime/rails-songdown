
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class VerseHeader < SongdownCompiler::Node
      def to_html
        @content.gsub!(
          SongdownCompiler::Tokens::VERSE_ANY_HEADER,
          SongdownCompiler::Tokens::VERSE_START
        )

        """
        <div class='sd-verse-header'>
          #{@content}
        </div>
        """
      end
    end
  end
end
