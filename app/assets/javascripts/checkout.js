function createTableRow(data){
  var row = '<tr>' +
              '<td>' + data.id + '</td>' +
              '<td><img class="img-fluid" src="' + data.img_url + '" />' + data.name + '</td>' +
              '<td>' + data.quatity + '</td>' +
              '<td>$' + data.price + '</td>' +
            '</tr>'
  return row;
}

function addressSelect(){
  var address = $('#address').find(":selected").text();
  if(address === 'Choose new address'){
    $('#shipping').show()
  } else{
    $('#shipping').hide()
  }
}

$( document ).ready(function() {
  //initial
  if (!($(".orders").length > 0)) {
    return;
  }
  $('#cart-show-btn').hide();
  $('#shipping').hide()

  //render data
  $.LoadingOverlay("show");
  $.ajax({
    type: "GET",
    url: "/cart_init",
    success: function(res, textStatus, jqXHR){
      var total_price = 0;
      $.each(res.data, function(i, value){
        $('#order-detail .table tbody ').append(createTableRow(value));
        total_price += parseFloat(parseFloat(value.price));
      })
      $('.co-total-price').html('<p>Total: $' + total_price.toFixed(2) +'</p>');
      $.LoadingOverlay("hide");
    },
    error: function(jqXHR, textStatus, errorThrown){}
  })
})
