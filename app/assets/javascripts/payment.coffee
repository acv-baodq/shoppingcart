class Payment
  constructor: (payment) ->
    @payment = $(payment)
    @initOrder()
    @paypalEvent()
    @showAddress()

  showAddress: ->
    @payment.find('#go-to-address').on 'click', @handleShowAddress

  handleShowAddress: ->
    $(this).remove()
    $('.address-section').show()
    $('html, body').animate({
      scrollTop: $('.address-section').offset().top
    }, 500);

  paypalEvent: ->
    paypal.Button.render {
      env: 'sandbox'
      style:
        label: 'checkout'
        size:  'responsive'
        shape: 'pill'
        color: 'gold'
      payment: (data, actions) ->
        actions.request.post('/orders').then (res) ->
          if res.status == 'OK'
            res.id
          else
            toastr.error('Oops! Something when wrong')
      onAuthorize: (data, actions) ->
        # 2. Make a request to your server
        $.LoadingOverlay('show')
        actions.request.post('/orders/execute-payment',
          paymentID: data.paymentID
          payerID: data.payerID).then (res) ->
            if res.status == 'OK'
              toastr['success']('Checkout success')
              $.LoadingOverlay('hide')
              $(location).attr('href','/orders');
            else
              toastr['error'](res.messages)
          return
    }, '#paypal-button-container'

  collectProduct = ->
    data = []
    $.map $('.modal-content').data('cart'), (key, val) ->
      obj = key
      obj["currency"] = "USD"
      delete obj["id"]
      delete obj["img_url"]
      data.push obj
    data

  createTableRow = (data) ->
    row = '<tr>' +
            '<td>' + data.id + '</td>' +
            '<td><img class="img-fluid" src="' + data.img_url + '" />' + data.name + '</td>' +
            '<td>' + data.quantity + '</td>' +
            '<td>$' + data.price + '</td>' +
         '</tr>'
    row

  initOrder: ->
    $('#cart-show-btn').hide()
    $('.address-section').hide()
    $.ajax
      type: 'GET'
      url: '/carts'
      success: (res, textStatus, jqXHR) ->
        total_price = 0
        $('.modal-content').data('cart', res.data)
        $.each res.data, (i, value) ->
          $('#order-detail .table tbody ').append createTableRow(value)
          total_price += parseFloat(parseFloat(value.price)) * parseInt(value.quantity)
          return
        $('.co-total-price').html '<span>Total: $<strong>' + total_price.toFixed(2) + '</strong></span>'
        $.LoadingOverlay 'hide'
      error: (jqXHR, textStatus, errorThrown) ->

$(document).ready ->
  # #initial if controller is Order Controller
  if !($('#checkout').length > 0)
    return

  payment = new Payment($('#checkout-page'))
