class Address
  constructor: (address) ->
    @address = $(address)
    @init()
    @selectionEvent()

  init: ->
    @address.find('.new_address').hide()

  selectionEvent: ->
    @address.find('#address').on 'change', ->
      selectedItem = $(this).find(":selected").text();
      if selectedItem == 'Your Paypal address'
        $(".new_address").hide()
      else if selectedItem == 'Create new address'
        $(".new_address").show()
      else
        $(".new_address").hide()

jQuery ->
  address = new Address($('.address-section'))
