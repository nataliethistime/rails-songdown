
require 'songdown_compiler'

KEY_SCALES = {
  #         1       2       3   4       5       6       7
  :C  => %w(C   Db  D   Eb  E   F   Gb  G   Ab  A   Bb  B),

  #         1       2       3   4       5       6       7
  :Db => %w(Db  D   Eb  E   F   Gb  G   Ab  A   Bb  B   C),
  :D  => %w(D   Eb  E   F   F#  G   Ab  A   Bb  B   C   C#),

  #         1       2       3   4       5       6       7
  :Eb => %w(),
  :E  => %w(E   F   F#  G   G#  A   Bb  B   C   C#  D   D#),

  #         1       2       3   4       5       6       7
  :F  => %w(F   Gb  G   Ab  A   Bb  B   C   Db  D   Eb  E),

  #         1       2       3   4       5       6       7
  :Gb => %w(),
  :G  => %w(G   Ab  A   Bb  B   C   Db  D   Eb  E   F   F#),

  #         1       2       3   4       5       6       7
  :Ab => %w(),
  :A  => %w(A   Bb  B   C   C#  D   Eb  E   F   F#  G   G#),

  #         1       2       3   4       5       6       7
  :Bb => %w(),
  :B  => %w(B   C   C#  D   D#  E   F   F#  G   G#  A   A#),
}

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

    # puts '---'
    # puts scale
    # puts '---'
    #
    # puts "root_note: #{root_note}"
    # puts "new_root_note: #{new_root_note}"
    # puts "offset: #{offset}"
    # puts "result: #{scale.index(new_root_note) + offset}"

    scale.index(new_root_note) + offset
  end
end

def transpose_chord(current_key, new_key, chord)
  splitted = chord.split('/')
  if splitted.size > 1
    transposed = splitted.map do |splitted_part|
      puts splitted_part
      transpose_chord(current_key, new_key, splitted_part)
    end

    return transposed.join('/')
  end

  index = chord_to_scale_degree(current_key, chord)
  KEY_SCALES[new_key.to_sym][index] + get_rest_of_chord(chord)
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
