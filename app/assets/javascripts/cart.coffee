class @Cart
  constructor: (cart) ->
    @cart = $(cart)
    @id = @cart.data('id')
    @deleteEvent()

  deleteEvent: ->
    @cart.find('.delete-product').on 'click', @handleDelete

  handleDelete: =>
    $.LoadingOverlay 'show'
    $.ajax
      type: 'DELETE'
      url: "/carts/#{@id}"
      success: @handleAjaxSuccess

  handleAjaxSuccess: (res) =>
    @cart.remove()
    cartCount()
    $.LoadingOverlay 'hide'
    toastr.success res.messages
