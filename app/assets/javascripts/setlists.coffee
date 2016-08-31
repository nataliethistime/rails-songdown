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

handleSetlistItemsDragging = (el) ->
  dragula([el])
    .on('drop', ->
      # Make sure the "Rearrange Songs" button is shown.
      $('#setlist_items_rearrange_button').css('display', '')

      # Reoder the songs
      $('tr', '#setlist_item_rearrange').each((i) ->
        $(this).attr({
          'data-position': i
        })
      )
    )

handleRearrangeSetlistItems = (e) ->
  e.preventDefault()
  items = []

  $('tr', '#setlist_item_rearrange').each((i) ->
    items.push({
      position: i,
      id: $(this).attr('data-id')
    })
  )

  $.ajax({
    url: window.location.href.replace(/edit_items$/, 'rearrange_items'),
    type: 'post',
    data: JSON.stringify({items}),
    contentType: "application/json; charset=utf-8",
    traditional: true,
    success: ->
      $('#setlist_items_rearrange_button').css('display', 'none')
  })

init = ->
  $('#find_song').on 'ajax:success', handleSearch

  el = document.getElementById('setlist_item_rearrange')
  if el
    handleSetlistItemsDragging(el)

  $('div:first', '#setlist_items_rearrange_button').on('click', handleRearrangeSetlistItems)

$(document)
  .ready init
  .on 'page:load', init
