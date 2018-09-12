class Address
  constructor: (address) ->
    @address = $(address)
    @selectionEvent()
    @deleteEvent()

  deleteEvent: ->
    @address.find('#delete-address').on 'click', ->
      id = $('#address').find(':selected').data('address')['id']
      $.ajax
        type: 'DELETE'
        url: "/addresses/#{id}"
        success: (res) ->
          toastr.success('Delete success')
        error: (jqXHR, textStatus, errorThrown) ->
          toastr.error('Something went wrong')

  selectionEvent: ->
    @address.find('#address').on 'change', ->
      id = $(this).find(":selected").data('address').id
      $.ajax
        type: 'POST'
        url: "/addresses/#{id}/change_selected"
        success: (res) ->
        error: (jqXHR, textStatus, errorThrown) ->
          toastr['error']('Something went wrong')



jQuery ->
  address = new Address($('.address-section'))
