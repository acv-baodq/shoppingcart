function generate_list_product(data){
  $('#cart .modal-body').empty();
  var total_price = 0;
  $.each(data.data, function(i, value){
    var delete_item = '<a class="delete-product" href="javascript:void(0);" id="product-' + value.id + '" onclick="confirmDelete(' + value.id + ')"' + '>Remove</a>'
    var div = '<div class="modal-content">' +
        '        <img class="image-product-modal" src="' + value.img_url + '" />' +
        '        <div class="name-product-modal">' + value.name + '</div>' +
        '        <div class="price-product-modal">' + value.price + '$</div>' +
                    delete_item +
              '</div>';
    $('#cart .modal-body').append(div);
    total_price = data.total
  })
  $('#cart .modal-body').append('<div> Total price: ' + total_price + '$</div>');
}

function confirmDelete(id){
  $.LoadingOverlay("show");
  confirm('Are you sure?')
  $.ajax({
    type: "DELETE",
    url: "/carts/" + id,
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
    type: "PUT",
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
      url: "/carts/1",
      success: function(data, textStatus, jqXHR){
        generate_list_product(data);
        $('#cart').modal('show');
      },
      error: function(jqXHR, textStatus, errorThrown){}
    })
  });
});
