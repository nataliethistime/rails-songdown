
require 'songdown_compiler/tokens'
require 'songdown_compiler/nodes/verses'
require 'songdown_compiler/nodes/verse_header'
require 'songdown_compiler/nodes/markdown'
require 'songdown_compiler/nodes/goto'

class SongdownCompiler

  def initialize(text)
    # Normalize newlines..
    @text = text.gsub /\r\n/, "\n"
    @nodes = []
  end

  def get_sections(text)
    text.split SongdownCompiler::Tokens::VERSE_END
  end

  def get_lines(text)
    text.split SongdownCompiler::Tokens::NEWLINE
  end

  def get_verse_header_index(lines)
    verse_header_index = -1

    lines.each_with_index do |line, i|
      if !line.match(SongdownCompiler::Tokens::VERSE_ANY_HEADER).nil?
        verse_header_index = i
        break
      end
    end

    return verse_header_index
  end

  def parse
    get_sections(@text).each do |section|
      parse_section section
    end
  end

  def parse_section(section)
    lines = get_lines section

    # Skip empty sections and lines
    return unless lines.size > 0

    verse_header_index = get_verse_header_index lines

    if verse_header_index == -1
      parse_remaining_lines lines
    else
      header = lines[verse_header_index]
      verse_lines = lines.slice verse_header_index + 1, lines.size
      remaining_lines = lines.slice 0, verse_header_index

      parse_verse header, verse_lines, remaining_lines
    end
  end

  def parse_remaining_lines(remaining_lines)
    remaining_lines.each do |line|
      # Here, a line is either a GOTO marker or a bit of markdown.
      if line.match(SongdownCompiler::Tokens::GOTO).nil?
        @nodes.push SongdownCompiler::Nodes::Markdown.new line
      else
        @nodes.push SongdownCompiler::Nodes::Goto.new line
      end
    end
  end

  def parse_verse(header, verse_lines, remaining_lines)
    if Array(remaining_lines).size
      parse_remaining_lines remaining_lines
    end

    @nodes.push SongdownCompiler::Nodes::VerseHeader.new header

    case header
      when SongdownCompiler::Tokens::VERSE_COMMON_HEADER
        @nodes.push SongdownCompiler::Nodes::VerseCommon.new verse_lines
      when SongdownCompiler::Tokens::VERSE_CHORDS_HEADER
        @nodes.push SongdownCompiler::Nodes::VerseChords.new verse_lines
      when SongdownCompiler::Tokens::VERSE_LYRICS_HEADER
        @nodes.push SongdownCompiler::Nodes::VerseChords.new verse_lines
    end
  end

  def to_html
    html = @nodes.map(&:to_html).join("\n")

    """
    <div class='sd-song'>
      #{html}
    </div>
    """
  end
end
