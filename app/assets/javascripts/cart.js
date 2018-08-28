function generate_list_product(obj){
  $('#cart .modal-body #cart-content').empty();
  var total_price = 0;
  $.each(obj.data, function(i, value){
    total_price += value.quatity * value.price

    var quality_form = '<input class="form-control" type="text" />';
    var delete_item = '<a class="delete-product" href="javascript:void(0);" id="product-' + value.id + '" onclick="confirmDelete(' + value.id + ')"' + '>Remove All</a>'

    var div = '<div class="col-md-12">' +
                '<div class="row">' +
                  '<div class="col-md-8 modal-cart-content">' +
                    '<img class="image-product-modal" src="' + value.img_url + '" />' +
                    '<div class="name-product-modal"><a href="/products/' + value.id + '">' + value.name + '</a> x ' + value.quatity + '</div>' +
                    '<div class="price-product-modal">' + value.price + '$</div>' +
                  '</div>' +
                  '<div class="col-md-4 modal-cart-quality">' +
                     quality_form + delete_item
                  '</div>' +
                '</div>' +
              '</div>' +
              '<div class="clearfix"></div>';
    $('#cart .modal-body #cart-content').append(div);
  })
  $('#cart .modal-body #cart-content').append('<div> Total price: ' + total_price + '$</div>');
}

function confirmDelete(id){
  $.LoadingOverlay("show");
  confirm('Are you sure?')
  $.ajax({
    type: "DELETE",
    url: "/carts_delete/" + id,
    success: function(data, textStatus, jqXHR){
      $.LoadingOverlay("hide");
      generate_list_product(data);
      toastr.success(data.messages)

    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
}

function addProductToCart(id){
  $.LoadingOverlay("show");
  $.ajax({
    type: "POST",
    url: "/carts/" + id,
    success: function(data, textStatus, jqXHR){
      generate_list_product(data);
      $.LoadingOverlay("hide");
      toastr.success(data.messages)
    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
}
$( document ).ready(function() {
  // $( document ).on('turbolinks:load', function() {
  //need to fix turbolink
  $("#cart-show-btn").on('click', function(){
    $.ajax({
      type: "GET",
      url: "/carts",
      success: function(data, textStatus, jqXHR){
        generate_list_product(data);
        $('#cart').modal('show');
      },
      error: function(jqXHR, textStatus, errorThrown){}
    })
  });
});
