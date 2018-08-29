class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :guest_user # test for guest user, add devise later

  def add
    product = Product.find(params[:id].to_i)
    if(@cart.key? product.id.to_s)
      @cart[product.id.to_s]["quatity"] = @cart[product.id.to_s]["quatity"].to_i + 1
      return render :json => {data: @cart, messages: "Added #{product.name} x#{@cart[product.id.to_s]["quatity"]}" }
    else
      @data_build = {
        id: product.id,
        name: product.name,
        price: product.price,
        img_url: product.img_url
      }
      @data_build["quatity"] = 1
    end
    @cart[product.id.to_s] = @data_build
    render :json => {data: @cart, messages: "Added #{product.name} success" }
  end

  def show
    render :json => { data: @cart }
  end

  def destroy
    product = Product.find(params[:id].to_i)
    @cart.delete(product.id.to_s)
    render :json => {data: @cart, messages: "Delete #{product.name} success" }
  end

  def change_quatity
    data = params[:data]
    data.each do |key, val|
      if val == '0'
        @cart.delete(key)
        next
      end
      @cart[key]['quatity'] = val
    end
    render :json => {data: @cart, messages: "Saved all changes" }
  end

  private
    def guest_user
      session[:cart] ||= {}
      @cart = session[:cart]
    end
end
