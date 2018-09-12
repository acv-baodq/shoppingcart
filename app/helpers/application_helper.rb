module ApplicationHelper
  def payment_total_price(data)
    data['transactions'][0]['amount']['total']
  end

  def payment_total_products(data)
    data['transactions'][0]['item_list']['items'].size
  end

  def payment_product_items(data)
    data['transactions'][0]['item_list']['items']
  end

  def payment_address(data)
    address = data['transactions'][0]['item_list']['shipping_address']
    "#{address['recipient_name']}: #{address['line1']}, #{address['line2']}, #{address['state']}, #{address['country_code']}"
  end
end
