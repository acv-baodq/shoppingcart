jQuery ->
  $('#cart-show-btn').on 'click', ->
    $('#cart').modal 'show'

  if !($('.products').length > 0 || $('.categories').length > 0)
    $('#cart-show-btn').hide()
    return

  cartList = new CartList($('.modal-content'))
