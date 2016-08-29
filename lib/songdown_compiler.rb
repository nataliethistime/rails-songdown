
require 'songdown_compiler/tokens'
require 'songdown_compiler/nodes/verse_block_opener'
require 'songdown_compiler/nodes/verse_block_closer'
require 'songdown_compiler/nodes/verse_header'
require 'songdown_compiler/nodes/markdown'
require 'songdown_compiler/nodes/goto'

require 'songdown_compiler/verses_handler'

require 'songdown_transposer'

class SongdownCompiler

  attr_accessor :nodes
  attr_accessor :key

  def initialize(**args)
    @input = args[:input].gsub /\r\n/, "\n" # Normalize newlines
    @key = args[:key]
    @show_key =
      if [true, false].include? args[:show_key]
        args[:show_key]
      else
        true
      end
    @nodes = []

    get_sections(@input).each do |section|
      parse_section section
    end
  end

  def change_key(new_key)
    @nodes = SongdownTransposer.change_key(@nodes, @key, new_key)
    @key = new_key
  end

  def to_html
    html = @nodes.map(&:to_html).join("\n")

    key =
      if @show_key
        """
          <div>
            <strong>Key</strong>: #{@key}
          </div>

          <br />
        """
      else
        ""
      end

    """
    <div class='sd-song'>
      #{key}
      #{html}
    </div>
    """
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
    @nodes.push SongdownCompiler::Nodes::VerseBlockOpener.new

    verse_nodes =
      case header
        when SongdownCompiler::Tokens::VERSE_COMMON_HEADER
          SongdownCompiler::VersesHandler.handle_common_verse(verse_lines)
        when SongdownCompiler::Tokens::VERSE_CHORDS_HEADER
          SongdownCompiler::VersesHandler.handle_chords_verse(verse_lines)
        when SongdownCompiler::Tokens::VERSE_LYRICS_HEADER
          SongdownCompiler::VersesHandler.handle_lyrics_verse(verse_lines)
      end

    @nodes.concat verse_nodes
    @nodes.push SongdownCompiler::Nodes::VerseBlockCloser.new
  end
end
