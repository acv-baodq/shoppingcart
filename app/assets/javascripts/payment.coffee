createTableRow = (data) ->
  row = '<tr>' +
          '<td>' + data.id + '</td>' +
          '<td><img class="img-fluid" src="' + data.img_url + '" />' + data.name + '</td>' +
          '<td>' + data.quantity + '</td>' +
          '<td>$' + data.price + '</td>' +
       '</tr>'
  row

collectProduct = ->
  data = []
  $.map $('.modal-content').data('cart'), (key, val) ->
    obj = key
    obj["currency"] = "USD"
    delete obj["id"]
    delete obj["img_url"]
    data.push obj
  data

shippingDetail = ->
  detail = {}
  detail['recipient_name'] = $('#full-name').val()
  detail['line1'] = $('#address').find(':selected').text()
  detail['line2'] = ''
  detail['city'] = 'HCM'
  detail['country_code'] = 'VN'
  detail['postal_code'] = '70000'
  detail['phone'] = $('#phone').val()
  detail['state'] = 'HCM'

  detail

class Payment
  constructor: (payment) ->
    @payment = $(payment)
    @initOrder()
    @toggleMapEvent()
    @paypalEvent()

  paypalEvent: ->
    paypal.Button.render {
      env: 'sandbox'
      client: sandbox: 'ARbPOn02Xwrvl1PG9KQGWyaFdSneDVuIPWKOdhHE3mbKXJf6sTGUF67z43L6e2uTUCMhfqn-2uMUQ0Lu'
      style:
        label: 'checkout'
        size: 'responsive'
        shape: 'pill'
        color: 'gold'
      commit: true
      payment: (data, actions) ->
        # Make a call to the REST api to create the payment
        actions.payment.create payment: transactions: [{
          amount:
            total: $('.co-total-price').find('strong').text()
            currency: 'USD'
          item_list:
            items: collectProduct()
            shipping_address: shippingDetail()
        }]
      onAuthorize: (data, actions) ->
        # Make a call to the REST api to execute the payment
        actions.payment.execute().then ->
          window.alert 'Payment Complete!'
          return
    }, '#paypal-button-container'

  toggleMapEvent: ->
    @payment.find('#address').on 'change', @handleToggleMap

  handleToggleMap: ->
    address = $(this).find(':selected').text()
    if address == 'Choose new address'
      $('#shipping').show()
    else
      $('#shipping').hide()
    return

  initOrder: ->
    $.ajax
      type: 'GET'
      url: '/carts'
      success: (res, textStatus, jqXHR) ->
        total_price = 0
        $('.modal-content').data('cart', res.data.data)
        $.each res.data.data, (i, value) ->
          $('#order-detail .table tbody ').append createTableRow(value)
          total_price += parseFloat(parseFloat(value.price))
          return
        $('.co-total-price').html '<span>Total: $<strong>' + total_price.toFixed(2) + '</strong></span>'
        $.LoadingOverlay 'hide'
      error: (jqXHR, textStatus, errorThrown) ->


$(document).ready ->
  # #initial if controller is Order Controller
  if !($('.orders').length > 0)
    return

  $('#cart-show-btn').hide()
  $('#shipping').hide()

  payment = new Payment($('#checkout-page'))

  setTimeout (->
    collectProduct()
    return
  ), 3000

  #render data
