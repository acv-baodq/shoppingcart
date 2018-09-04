jQuery ->
  $('#cart-show-btn').on 'click', ->
    $('#cart').modal 'show'

  if !($('.products').length > 0)
    return

  cartList = new CartList($('.modal-content'))
