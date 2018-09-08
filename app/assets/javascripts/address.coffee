class Address
  constructor: (address) ->
    @address = $(address)
    @init()
    # @selectionEvent()
    # @createNewAddress()


  init: ->
    # $("#shipping").hide()
    # $('#paypal-button-container').hide()

  # createNewAddress: ->
  #   $('#create-new-address').on 'click', (event) ->


  # selectionEvent: ->
  #   @address.find('#address').on 'change', ->
  #     inputText = $(this).find(":selected").text();
  #     that = $(this).find(":selected")
  #     if inputText == 'Your Paypal address'
  #       $("#shipping").hide()
  #       $('#show-form-address').hide()
  #     else if inputText == 'Create new address'
  #       $('form').attr('action', "/addresses")
  #       $('form input[type=hidden]').val('post')
  #
  #       $("#shipping").show()
  #       $('#shipping form').show()
  #       $('#show-form-address').hide()
  #       #Clear previous form
  #       $.each that.data('address'), (key,val) ->
  #         $("#address_#{key}").val("")
  #     else
  #       # $("#shipping").show()
  #       # $('#shipping form').show()
  #       $('#show-form-address').show()
  #       $('form input[type=hidden]').val('put')
  #       $('form').attr('action', "/addresses/#{that.attr('id')}")
  #       $.each that.data('address'), (key,val) ->
  #         if key == 'country_code'
  #           code = $('#address_country_code option').filter(->
  #             $(this).html() == val
  #           ).val()
  #           $('#address_country_code').val(code)
  #         else
  #           $("#address_#{key}").val(val)

jQuery ->
  address = new Address($('.address-section'))
