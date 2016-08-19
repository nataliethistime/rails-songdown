
require 'songdown_compiler/node'

def chords_line(line)
  '<pre class="chords">' + line + '<br /></pre>'
end

def lyrics_line(line)
  '<pre class="lyrics">' + line + '<br /></pre>'
end

def verse_block(lines)
  '<div class="verse">' + lines.join("\n") + '</div>'
end

class SongdownCompiler
  class Nodes

    #
    # This verse has chords and lyrics.
    #
    class VerseCommon < SongdownCompiler::Node
      def to_html
        lines = Array(@section).each_with_index.map do |line, i|
          # This is done for my personal sanity.
          current_line_number = i + 1

          # Every odd-numbered line is chords. Every other line is lyrics.
          if current_line_number.odd?
            chords_line line
          else
            lyrics_line line
          end
        end

        verse_block lines
      end
    end

    #
    # This verse has just chords.
    #
    class VerseChords < SongdownCompiler::Node
      def to_html
        lines = Array(@section).map &:chords_line
        verse_block lines
      end
    end

    #
    # This verse has just lyrics.
    #
    class VerseLyrics < SongdownCompiler::Node
      def to_html
        lines = Array(@section).map &:lyrics_line
        verse_block lines
      end
    end
  end
end
