class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :guest_user # test for guest user, add devise later

  def add
    product = Product.find(params[:id].to_i)
    data_build = {
      id: product.id,
      name: product.name,
      price: product.price,
      img_url: product.img_url
    }
    if(@cart.data.key? product.id.to_s)
      data_build['quatity'] = @cart.data[product.id.to_s]["quatity"].to_i + 1
    else
      data_build['quatity'] = 1
    end
    @cart.data[product.id] = data_build
    @cart.save
    render :json => {data: @cart.data, messages: "Added #{product.name} success" }
  end

  def show
    render :json => { data: @cart.data }
  end

  def destroy
    product = Product.find(params[:id].to_i)
    @cart.data.delete(product.id.to_s)
    render :json => {data: @cart.data, messages: "Delete #{product.name} success" } if @cart.save
  end

  def change_quatity
    data = params[:data]
    data.each do |key, val|
      if val == "0"
        @cart.data.delete(key)
        next
      end
      @cart.data[key]['quatity'] = val
    end
    render :json => {data: @cart.data, messages: "Saved all changes" } if @cart.save
  end

  private
    def guest_user
      id = session[:cart_id]
      @cart = Cart.find_or_create_by(id: id)
      session[:cart_id] = @cart.id if id.nil?
    end
end
