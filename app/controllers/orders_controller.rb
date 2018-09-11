require 'paypal-sdk-rest'

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end

  def checkout

  end

  def index
    @orders = current_user.orders
  end

  def create
    @payment = PayPal::SDK::REST::Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal"
      },
      :redirect_urls => {
        :return_url => "http://localhost:3000/categories",
        :cancel_url => "http://localhost:3000/products"
      },
      :transactions =>  [
        {
          :item_list => {
            :items => get_list_items,
            shipping_address: get_shipping_address(current_user.id)
          },
          :amount =>  {
            :total =>  @cart['total_price'].to_s,
            :currency =>  "USD"
          },
          :description =>  "This is the payment transaction description."
        }
      ]
    })
    if @payment.create
      render json: { id: @payment.id }
    else
      render json: { error: @payment.error }
    end
  end

  def execute_payment
    payment = PayPal::SDK::REST::Payment.find(params['paymentID'])
    if payment.execute( :payer_id => params['payerID'] )
      binding.pry
      # UserMailer.checkout_success(current_user, current_user.cart).deliver
      current_user.cart.destroy
      @order = Order.new(user_id: current_user.id, data: payment)
      @order.save
      render json: {data: payment}
    else
      payment.error # Error Hash
    end
  end

  private
    def get_list_items
      list_items = []
      @cart['data'].each do |key, val|
        item = val
        item['currency'] = 'USD'
        list_items << item.except("id", "img_url")
      end
      list_items
    end

    def get_shipping_address(id)
      address = Address.get_selected(id)
      country_code = ISO3166::Country.find_country_by_name(address.country_code).alpha2
      return {
        recipient_name: current_user.full_name,
        line1: address.line1,
        line2: address.line2.present? ? address.line2 : nil,
        city: address.city,
        country_code: country_code,
        postal_code: address.postal_code,
        phone: current_user.phone,
        state: address.state.present? ? address.state : nil
      }
    end
end
