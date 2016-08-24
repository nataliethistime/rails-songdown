module SongsHelper
  def embed_youtube(youtube_url)
    if youtube_url.nil? || youtube_url.empty?
      ''
    else
      video_id = youtube_url.split("=").last
      content_tag(
        :iframe,
        nil,
        :src => "//www.youtube.com/embed/#{video_id}",
        :frameborder => '0',
        :allowfullscreen => '1',
        :width => '100%',
        :height => '300px'
      )
    end
  end
end
