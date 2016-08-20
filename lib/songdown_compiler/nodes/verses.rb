
require 'songdown_compiler/node'

def chords_line(line)
  '<div class="sd-chords-line">' + line + '</div>'
end

def lyrics_line(line)
  '<div class="sd-lyrics-line">' + line + '</div>'
end

def verse_block(lines)
  '<div class="sd-verse-block">' + lines.join("\n") + '</div>'
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
        lines = Array(@section).map do |line|
          chords_line line
        end

        verse_block lines
      end
    end

    #
    # This verse has just lyrics.
    #
    class VerseLyrics < SongdownCompiler::Node
      def to_html
        lines = Array(@section).map do |line|
          lyrics_line line
        end

        verse_block lines
      end
    end
  end
end
