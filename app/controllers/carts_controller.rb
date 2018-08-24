class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @cart = Cart.first
    product = Product.find(params[:id].to_i)
    product.cart_id = @cart.id
    product.save
    render :json => @cart.products
  end

  def show
    @cart = Cart.first.products
    render :json => { data: @cart, total: Cart.get_total }
  end

  def destroy
    @cart = Cart.first
    @cart.products.delete(Product.find(params[:id]))
    render :json => @cart.products
  end
end
