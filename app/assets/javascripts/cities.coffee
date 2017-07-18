# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
template = (item) -> item.text

jQuery(document).on 'turbolinks:load', ->
  $('#to').select2
    ajax: {
      url: '/users'
      data: (params) ->
        {
          term: params.term
        }
      dataType: 'json'
      delay: 500
      processResults: (data, params) ->
        {
          results: _.map(data, (el) ->
            {
              id: el.id
              name: "#{el.surname}, #{el.name}"
            }
          )
        }
      cache: true
    }
    escapeMarkup: (markup) -> markup
    minimumInputLength: 2
    templateResult: (item) -> item.name
    templateSelection: (item) -> item.name