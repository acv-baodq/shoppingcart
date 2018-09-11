class Address
  constructor: (address) ->
    @address = $(address)
    @selectionEvent()

  selectionEvent: ->
    @address.find('#address').on 'change', ->
      $.LoadingOverlay('show')
      id = $(this).find(":selected").data('address').id
      $.ajax
        type: 'POST'
        url: "/addresses/#{id}/change_selected"
        success: (res) ->
          $.LoadingOverlay('hide')
        error: (jqXHR, textStatus, errorThrown) ->
          toastr['error']('Something went wrong')



jQuery ->
  address = new Address($('.address-section'))
