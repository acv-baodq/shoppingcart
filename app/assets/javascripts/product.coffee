class Product
  constructor: (product) ->
    @product = $(product)
    @id = @product.data('id')
    @addToCart()

  addToCart: ->
    @product.find('.btn-cart').on 'click', @handleAddToCart

  handleAddToCart: =>
    debugger
    $.LoadingOverlay 'show'
    id = @id
    $("#cart-item-#{@id}").remove()
    $.ajax
      type: 'PUT'
      url: "/carts/#{@id}"
      success: (res, textStatus, jqXHR) ->
        data =
          "#{id}": res.data
        generate_list_product data
        cart = new Cart($('.cart-items').last())
        $.LoadingOverlay 'hide'
        toastr.success res.messages
        return
      error: (jqXHR, textStatus, errorThrown) ->
    return

jQuery ->
  products = $.map $('.product-item'), (product, i) ->
    new Product(product)
