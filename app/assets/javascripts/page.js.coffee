jQuery ->
  $('#pages').sortable
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))