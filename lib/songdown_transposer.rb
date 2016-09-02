
require 'songdown_compiler'

KEY_SCALES = {
  #           1       2       3   4       5       6       7
  :Cb   => %W(Cb C Db D Eb Fb F Gb G Ab A Bb B),
  :C    => %w(C   Db  D   Eb  E   F   Gb  G   Ab  A   Bb  B),
  :'C#' => %w(C#  D   D#  E   E#  F#  G   G#  A   A#  B   B#),

  #           1       2       3   4       5       6       7
  :Db   => %w(Db  D   Eb  E   F   Gb  G   Ab  A   Bb  B   C),
  :D    => %w(D   Eb  E   F   F#  G   Ab  A   Bb  B   C   C#),
  :'D#' => %w(D#  E   E#  F#  G   G#  A   A#  B   B#  C#  D),

  #           1       2       3   4       5       6       7
  :Eb   => %w(Eb  E   F   Ab  G   Ab  A   Bb  B   C   Db  D),
  :E    => %w(E   F   F#  G   G#  A   Bb  B   C   C#  D   D#),
  :'E#' => %w(E#  F#  G   G#  A   A#  B   B#  C#   D  D#  E),

  #           1       2       3   4       5       6       7
  :Fb   => %w(Fb  F   Gb  G   Ab  A   Bb  Cb  C   Db  D   Eb),
  :F    => %w(F   Gb  G   Ab  A   Bb  B   C   Db  D   Eb  E),
  :'F#' => %w(F#  G   G#  A   A#  B   C   C#  D   D#  E   E#),

  #           1       2       3   4       5       6       7
  :Gb   => %w(Gb  G   Ab  A   Bb  Cb  C   Db  D   Eb  E   F),
  :G    => %w(G   Ab  A   Bb  B   C   Db  D   Eb  E   F   F#),
  :'G#' => %w(G#  A   A#  B   B#  C#  D   D#  E   E#  F#  G),

  #           1       2       3   4       5       6       7
  :Ab   => %w(Ab  A   Bb  B   C   Db  D   Eb  E   F   Gb  G),
  :A    => %w(A   Bb  B   C   C#  D   Eb  E   F   F#  G   G#),
  :'A#' => %w(A#  B   B#  C#  D   D#  E   E#  F#  G   G#  A),

  #           1       2       3   4       5       6       7
  :Bb   => %w(Bb  B   C   Db  D   Eb  E   F   Gb  G   Ab  A),
  :B    => %w(B   C   C#  D   D#  E   F   F#  G   G#  A   A#),
  :'B#' => %w(B#  C#  D   D#  E   E#  F#  G   G#  A   A#  B),
}

KEY_SCALES.default_proc = proc do |hash, key|
  raise "Key #{key} not found in KEY_SCALES"
end

def get_root_note(chord)
  root_note = chord[0]

  # Handle accidentals (if any) after the root note.
  if chord[1] == '#' || chord[1] == 'b'
    root_note += chord[1]
  end

  root_note
end

def get_rest_of_chord(chord)
  root_note = get_root_note(chord)
  chord.gsub(root_note, '')
end

def chord_to_scale_degree(key, chord)
  scale = KEY_SCALES[key.to_sym]
  root_note = get_root_note(chord)

  scale_degree = scale.index(root_note)

  if scale_degree
    return scale_degree
  else
    new_root_note = root_note[0]
    offset =
      case root_note[1]
        when 'b'
          -1
        when '#'
          1
        else
          0
      end

    scale.index(new_root_note) + offset
  end
end

def transpose_split_chord(current_key, new_key, split_chord)
  splitted = split_chord.split('/')

  chord = splitted[0]
  base = splitted[1]

  transposed_chord = transpose_standard_chord(current_key, new_key, chord)
  transposed_base = transpose_standard_chord(
    get_root_note(chord),
    get_root_note(transposed_chord),
    base
  )

  "#{transposed_chord}/#{transposed_base}"
end

def transpose_standard_chord(current_key, new_key, chord)
  index = chord_to_scale_degree(current_key, chord)
  KEY_SCALES[new_key.to_sym][index] + get_rest_of_chord(chord)
end

def transpose_chord(current_key, new_key, chord)
  if chord.split('/').size > 1
    transpose_split_chord(current_key, new_key, chord)
  else
    transpose_standard_chord(current_key, new_key, chord)
  end
end

def transpose_line(current_key, new_key, line)
  line.gsub!(/\S+/) do |chord|
    transpose_chord(current_key, new_key, chord)
  end
end

class SongdownTransposer
  def self.change_key(nodes, current_key, new_key)

    nodes.map do |node|
      if node.instance_of? SongdownCompiler::Nodes::ChordsLine
        lines = Array(node.content)

        node.content =
          lines.map do |line|
            transpose_line(current_key, new_key, line)
          end
      end

      node
    end
  end
end
