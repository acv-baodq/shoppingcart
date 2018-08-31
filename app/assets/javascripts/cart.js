function createHtmlForCart(value){
  return '<div class="col-md-12" id="cart-item-' + value.id + '">' +
              '<div class="row">' +
                '<div class="col-md-8 modal-cart-content">' +
                  '<img class="image-product-modal" src="' + value.img_url + '" />' +
                  '<div class="name-product-modal"><a href="/products/' + value.id + '">' + value.name + '</a></div>' +
                  '<div class="price-product-modal">' + value.price + '$</div>' +
                '</div>' +
                '<div class="col-md-4 modal-cart-quality">' +
                  '<input value=' + value.quatity + ' id="quatity-' + value.id + '" class="form-control" type="number" />' +
                  '<a class="delete-product" href="javascript:void(0);" id="product-' + value.id + '" onclick="confirmDelete(' + value.id + ')"' + '>Remove All</a>' +
                '</div>' +
              '</div>' +
            '</div>' +
            '<div class="clearfix"></div>';
}

function cartCount(){
  var quatity = 0;
  $.each($("input[id^='quatity-']"), function(key, val){
    quatity += parseInt(val.value)
  })
  $('#cart-count').text('(' + quatity + ')');
}

function generate_list_product(data){
  if(typeof data.data === 'object'){
    $('#cart .modal-body #cart-content').empty();
    var total_price = 0;
    $.each(data.data, function(i, value){
      $('#cart .modal-body #cart-content').append(createHtmlForCart(value));
    })
  } else {
    $('#cart .modal-body #cart-content').append(createHtmlForCart(data));
  }
  cartCount();
}

function confirmDelete(id){
  confirm('Are you sure?');
  $.LoadingOverlay("show");
  $.ajax({
    type: "DELETE",
    url: "/carts_delete/" + id,
    success: function(res, textStatus, jqXHR){
      $('#cart-item-' + id).remove();
      cartCount();
      $.LoadingOverlay("hide");
      toastr.success(res.messages);

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
      $('#cart-item-' + id).remove();
      generate_list_product(res.data);
      $.LoadingOverlay("hide");
      toastr.success(res.messages)
    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
}

function cartInit(){
  $.ajax({
    type: "GET",
    url: "/cart_init",
    success: function(res, textStatus, jqXHR){
      generate_list_product(res.data);
    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
}

$( document ).ready(function() {
  // $( document ).on('turbolinks:load', function() {
  //need to fix turbolink
  cartInit();
  $("#cart-show-btn").on('click', function(){
    $('#cart').modal('show');
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
        cartCount();
        $.LoadingOverlay("hide");
        toastr.success(res.messages)
      },
      error: function(jqXHR, textStatus, errorThrown){}
    })
  })
});
