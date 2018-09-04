class CartList
  constructor: (cartList) ->
    @cartList = $(cartList)
    @initData()
    @updatequantityEvent()

  updatequantityEvent: ->
    @cartList.find('.change-quantity').on 'click', @getquantityEvent

  getquantityEvent: ->
    $.LoadingOverlay 'show'
    inputquantity = $('input[id^=\'quantity-\']')
    data = {}
    $.each inputquantity, (key, val) ->
      id = val.id.match(/\d/g)
      id = id.join('')
      data[id] = if parseInt(val.value) > 0 then parseInt(val.value) else 0
      $("#cart-item-#{id}").remove() if data[id] == 0
    $.ajax
      type: 'POST'
      url: '/carts'
      data: { data: data }
      success: (res, textStatus, jqXHR) ->
        cartCount()
        $.LoadingOverlay 'hide'
        toastr.success res.messages
        return
      error: (jqXHR, textStatus, errorThrown) ->
    return

  initData: ->
    $.ajax
      type: 'GET'
      url: '/carts'
      success: @handleInitDataSuccess

  handleInitDataSuccess: (res) =>
    generate_list_product res.data
    carts = $.map $('.cart-items'), (cart, i) ->
      new Cart(cart)

jQuery ->
  # Init cart and create Class instance
  if !($('.products').length > 0)
    return

  cartList = new CartList($('.modal-content'))
