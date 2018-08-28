class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :guest_user # test for guest user, add devise later

  def update
    product = Product.find(params[:id].to_i)
    @cart.products << product
    render :json => {data: @cart.products, total: @cart.get_total, messages: "Added #{product.name} success" }
  end

  def show
    data = @cart.products.empty? ? [] : @cart.products
    render :json => { data: data, total: @cart.get_total }
  end

  def destroy
    product = Product.find(params[:id].to_i)
    @cart.products.delete(product)
    render :json => {data: @cart.products, total: @cart.get_total, messages: "Delete #{product.name} success" }
  end

  private
    def guest_user
      id = session[:cart_id]
      @cart = Cart.find_or_create_by(id: id)
      session[:cart_id] = @cart.id if id.nil?
    end
end
