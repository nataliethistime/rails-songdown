
require 'songdown_compiler/node'

class SongdownCompiler
  class Nodes
    class VerseHeader < SongdownCompiler::Node
      def to_html
        @section.gsub!(
          SongdownCompiler::Tokens::VERSE_CHORDS_HEADER,
          SongdownCompiler::Tokens::VERSE_START
        )

        @section.gsub!(
          SongdownCompiler::Tokens::VERSE_LYRICS_HEADER,
          SongdownCompiler::Tokens::VERSE_START
        )

        '<br /><span class="verse-head">' + @section + '</span><br />'
      end
    end
  end
end
