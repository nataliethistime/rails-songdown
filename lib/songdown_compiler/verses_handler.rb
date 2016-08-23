
require 'songdown_compiler/nodes/chords_line'
require 'songdown_compiler/nodes/lyrics_line'

class SongdownCompiler
  class VersesHandler
    def self.handle_common_verse(lines)
      lines.each_with_index.map do |line, i|
        current_line_number = i + 1 # Undo 0-based index

        # Every odd-numbered line is chords. Every other line is lyrics.
        if current_line_number.odd?
          SongdownCompiler::Nodes::ChordsLine.new line
        else
          SongdownCompiler::Nodes::LyricsLine.new line
        end
      end
    end

    def self.handle_chords_verse(lines)
      lines.map do |line|
        SongdownCompiler::Nodes::ChordsLine.new line
      end
    end

    def self.handle_lyrics_verse(lines)
      lines.map do |line|
        SongdownCompiler::Nodes::LyricsLine.new line
      end
    end
  end
end
