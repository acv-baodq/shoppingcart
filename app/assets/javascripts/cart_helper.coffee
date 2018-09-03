@createHtmlForCart = (value) ->
  '<div class="col-md-12 cart-items" id="cart-item-' + value.id + '" data-id=' + value.id + '>' +
    '<div class="row">' +
      '<div class="col-md-8 modal-cart-content">' +
        '<img class="image-product-modal" src="' + value.img_url + '" />' +
        '<div class="name-product-modal"><a href="/products/' + value.id + '">' + value.name + '</a></div>' +
        '<div class="price-product-modal">' + value.price + '$</div>' + '</div>' +
      '<div class="col-md-4 modal-cart-quality">' +
        '<input value=' + value.quantity + ' id="quantity-' + value.id + '" class="form-control" type="number" />' +
        '<a class="delete-product" href="javascript:void(0);" id="product-' + value.id + '">Remove All</a>' +
      '</div>' +
    '</div>' +
  '</div>' +
  '<div class="clearfix"></div>'

@cartCount = ->
  quantity = 0
  $.each $('input[id^=\'quantity-\']'), (key, val) ->
    quantity += parseInt(val.value)
    return
  $('#cart-count').text '(' + quantity + ')'
  return

@generate_list_product = (data) ->
  if typeof data.data == 'object'
    $('#cart .modal-body #cart-content').empty()
    total_price = 0
    $.each data.data, (i, value) ->
      $('#cart .modal-body #cart-content').append createHtmlForCart(value)
      return
  else
    $('#cart .modal-body #cart-content').append createHtmlForCart(data)
  cartCount()
  return
