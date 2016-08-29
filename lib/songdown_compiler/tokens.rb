
class SongdownCompiler
  class Tokens
    VERSE_START = ':'
    VERSE_END = /^---/
    VERSE_COMMON_HEADER = /\:$/x
    VERSE_CHORDS_HEADER = /\+$/x
    VERSE_LYRICS_HEADER = /\-$/x
    VERSE_ANY_HEADER = /[:+-]$/x
    NEWLINE = "\n"
    GOTO = /^\-\>/
  end
end
