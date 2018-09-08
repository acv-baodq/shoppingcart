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
    $.LoadingOverlay 'show'
    # $.ajax
    #   type: 'GET'
    #   url: "/addresses"
    #   success: (res) ->
    #     $.each res.data, (index, value) ->
    #       $('#address').append("<option data-address='#{JSON.stringify(value)}' id=#{value.id}>#{value.line1} #{value.line2} #{value.city}, #{value.state}, #{value.postal_code}, #{value.country_code} </option>")
    $('.address-section').show()
    $('html, body').animate({
      scrollTop: $('.address-section').offset().top
    }, 500);
    $.LoadingOverlay 'hide'

  paypalEvent: ->
    paypal.Button.render {
      env: 'sandbox'
      client: sandbox: 'ARbPOn02Xwrvl1PG9KQGWyaFdSneDVuIPWKOdhHE3mbKXJf6sTGUF67z43L6e2uTUCMhfqn-2uMUQ0Lu'
      style:
        label: 'checkout'
        size:  'responsive'
        shape: 'pill'
        color: 'gold'
      commit: true
      payment: (data, actions) ->
        # Make a call to the REST api to create the payment
        shippingAddress = getShippingAddress()
        console.log('shipping', shippingAddress)
        actions.payment.create payment: transactions: [{
          amount:
            total: $('.co-total-price').find('strong').text()
            currency: 'USD'
          item_list:
            items: collectProduct()
            shipping_address: shippingAddress
            # shipping_address: undefined
        }]
      onAuthorize: (data, actions) ->
        # Make a call to the REST api to execute the payment
        actions.payment.execute().then ->
          window.alert 'Payment Complete!'
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

  getShippingAddress = ->
    data = $('#address').find(":selected").data('address')
    detail = {}

    detail['line1'] = if data['line1'] && data['line1'].length > 0 then data['line1'] else undefined
    detail['line2'] = if data['line2'] && data['line2'].length > 0 then data['line2'] else undefined
    detail['city'] = if data['city'] && data['city'].length > 0 then data['city'] else undefined
    detail['state'] = if data['state'] && data['state'].length > 0 then data['state'] else undefined
    detail['postal_code'] = if data['postal_code'] && data['postal_code'].length > 0 then data['postal_code'] else undefined

    detail['country_code'] = 'US'
    detail['recipient_name'] = $('#recipient_name').val()
    detail['phone'] = $('#phone').val()
    return detail

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
  if !($('.orders').length > 0)
    return

  payment = new Payment($('#checkout-page'))
