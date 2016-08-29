require 'songdown_compiler'

module HelpHelper
  def compile_songdown(input)
    compiler = SongdownCompiler.new(
      :input => input,
      :show_key => false,
    )

    compiler.to_html
  end
end
