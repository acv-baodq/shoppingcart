function generate_list_product(obj){
  $('#cart .modal-body #cart-content').empty();
  var total_price = 0;
  $.each(obj, function(i, value){
    total_price += value.quatity * value.price

    var quality_form = '<input value=' + value.quatity + ' id="quatity-' + value.id + '" class="form-control" type="number" />';
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
    success: function(res, textStatus, jqXHR){
      $.LoadingOverlay("hide");
      generate_list_product(res.data);
      toastr.success(res.messages)

    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
}

function addProductToCart(id){
  $.LoadingOverlay("show");
  $.ajax({
    type: "POST",
    url: "/carts/" + id,
    success: function(res, textStatus, jqXHR){
      generate_list_product(res.data);
      $.LoadingOverlay("hide");
      toastr.success(res.messages)
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
      success: function(res, textStatus, jqXHR){
        generate_list_product(res.data);
        $('#cart').modal('show');
      },
      error: function(jqXHR, textStatus, errorThrown){}
    })
  });

  $(".change-quatity").on('click', function change_quatity(){
    $.LoadingOverlay("show");
    var inputQuatity = $("input[id^='quatity-']");
    var data = {};
    $.each(inputQuatity, function(key, val) {
      var id = val.id.match(/\d/g);
      id = id.join("");
      data[id] = parseInt(val.value) > 0 ? parseInt(val.value) : 0;
    })
    $.ajax({
      type: "POST",
      url: "/carts_quatity",
      data: {data: data},
      success: function(res, textStatus, jqXHR){
        generate_list_product(res.data);
        $.LoadingOverlay("hide");
        toastr.success(res.messages)
      },
      error: function(jqXHR, textStatus, errorThrown){}
    })
  })
});
