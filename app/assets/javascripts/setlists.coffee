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

    $('#setlist_item_title').val(song.title)
    $('#setlist_item_song_id').val(song.id)
    $('#setlist_item_artist').val(song.artist)
    $('#setlist_item_key').val(song.key)

handleSearch = (e, data, status, xhr) ->
  songs = JSON.parse xhr.responseText
  list = []

  for song in songs

    list.push """
      <li>
        <a class='fancy-link' data-song-id='#{song.id}' href='#'>#{song.artist} - #{song.title}</a>
      </li>
    """

  $('#results').html """
    <h2>Results</h2>

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

init = ->
  $('#find_song').on 'ajax:success', handleSearch

$(document)
  .ready init
  .on 'page:load', init
