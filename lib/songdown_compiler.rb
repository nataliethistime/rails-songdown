
require 'songdown_compiler/tokens'
require 'songdown_compiler/nodes/verses'
require 'songdown_compiler/nodes/verse_header'
require 'songdown_compiler/nodes/markdown'

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
      # This happens when there is no header in the current section. In which case, we assume
      # that it is all a markdown block.
      #
      # NOTE: this is not the full solution - there are also goto nodes to take care of.
      parse_markdown lines
    else
      header = lines[verse_header_index]
      verse_lines = lines.slice verse_header_index + 1, lines.size
      remaining_lines = lines.slice 0, verse_header_index

      parse_verse header, verse_lines, remaining_lines
    end
  end

  def parse_markdown(input)
    @nodes.push SongdownCompiler::Nodes::Markdown.new input
  end

  def parse_verse(header, verse_lines, remaining_lines)
    if Array(remaining_lines).size
      parse_markdown(remaining_lines)
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
    @nodes.map(&:to_html).join "\n"
  end
end
