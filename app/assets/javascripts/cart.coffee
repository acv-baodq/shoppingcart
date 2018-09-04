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

jQuery ->
  # Init cart and create Class instance
  if !($('.products').length > 0)
    return

  $('#cart-show-btn').on 'click', ->
    $('#cart').modal 'show'
