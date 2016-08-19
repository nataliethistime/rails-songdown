# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setSelectedSong = (songs, songId) ->
  song = undefined

  for possibleSong in songs
    if parseInt(possibleSong.id, 10) is parseInt(songId, 10)
      song = possibleSong

  if song?
    console.log('Selected:', song)

    $('#setlist_item_title').attr('value', song.title)
    $('#setlist_item_song_id').attr('value', song.id)
    $('#setlist_item_artist').attr('value', song.artist)

handleSearch = (e, data, status, xhr) ->
  songs = JSON.parse xhr.responseText
  list = []

  for song in songs

    list.push """
      <li>
        #{song.artist} - #{song.title} (<a data-song-id='#{song.id}' href='#'>select</a>)
      </li>
    """

  $('#results').html """
    <ul>
      #{list.join ''}
    </ul>
  """

  $('a', '#results').off()
    .on 'click', (e) ->
      e.preventDefault()
      $el = $ @
      setSelectedSong songs, $el.attr 'data-song-id'
    .on 'ajax:error', (e, data, status, error) ->
      $('#results').append 'ERROR'

setup = ->
  $('#find_song').on 'ajax:success', handleSearch

$(document)
  .ready setup
  .on 'page:load', setup
