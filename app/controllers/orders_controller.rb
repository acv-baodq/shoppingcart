
class OrdersController < ApplicationController
  def index

  end

  def create
    @payment = Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal" },
      :redirect_urls => {
        :return_url => "http://localhost:3000/catogories",
        :cancel_url => "http://localhost:3000/products" },
      :transactions =>  [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => "item",
            :price => "5",
            :currency => "USD",
            :quantity => 1 }]},
        :amount =>  {
          :total =>  "5",
          :currency =>  "USD" },
        :description =>  "This is the payment transaction description." }]})

    if @payment.create
      @payment.id     # Payment Id
    else
      @payment.error  # Error Hash
    end
  end
end
