module ApplicationHelper
  def payment_total_price(data)
    data['transactions'][0]['amount']['total']
  end

  def payment_total_products(data)
    data['transactions'][0]['item_list']['items'].size
  end
end
