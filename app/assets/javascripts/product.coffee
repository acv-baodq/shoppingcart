class Product
  constructor: (product) ->
    @product = $(product)
    @id = @product.data('id')
    @addToCart()

  addToCart: ->
    @product.find('.btn-cart').on 'click', @handleAddToCart

  handleAddToCart: =>
    $.LoadingOverlay 'show'
    $.ajax
      type: 'PUT'
      url: "/carts/#{@id}"
      success: (res, textStatus, jqXHR) ->
        $("#cart-item-#{@id}").remove()
        generate_list_product res.data
        $.LoadingOverlay 'hide'
        toastr.success res.messages
        return
      error: (jqXHR, textStatus, errorThrown) ->
    return

jQuery ->
  products = $.map $('.product-item'), (product, i) ->
    new Product(product)
