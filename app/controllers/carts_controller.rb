class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :guest_user # test for guest user, add devise later
  after_action :save_to_current_user

  def add
    product = Product.find(params[:id].to_i)
    if(@cart['data'].key? product.id.to_s)
      @cart['data'][product.id.to_s]['quatity'] = (@cart['data'][product.id.to_s]['quatity'].to_i + 1).to_s
      return render :json => {data: @cart['data'], messages: "Added #{product.name} x#{@cart['data'][product.id.to_s]['quatity']}" }
    else
      data_build = {
        'id': product.id.to_s,
        'name': product.name.to_s,
        'price': product.price.to_s,
        'img_url': product.img_url.to_s
      }
      data_build['quatity'] = '1'
    end
    @cart['data'][product.id.to_s] = data_build
    render :json => {data: @cart, messages: "Added #{product.name} success" }
  end

  def show
    render :json => { data: @cart['data'] }
  end

  def destroy
    product = Product.find(params[:id].to_i)
    @cart['data'].delete(product.id.to_s)
    render :json => {data: @cart['data'], messages: "Delete #{product.name} success" }
  end

  def change_quatity
    data = params[:data]
    data.each do |key, val|
      if val == '0'
        @cart['data'].delete(key)
        next
      end
      @cart['data'][key]['quatity'] = val
    end
    render :json => {data: @cart['data'], messages: "Saved all changes" }
  end

  private
    def guest_user
      if current_user
        @cart = Cart.find_or_create_by(user_id: current_user.id)
        if session[:cart].present?
          @cart.data = @cart.data.merge(session[:cart]['data'])
          @cart.save
          session[:cart] = nil
        end
        return
      end
      session[:cart] ||= {}
      session[:cart]['data'] = {} if session[:cart].empty?
      @cart = session[:cart]
    end

    def save_to_current_user
      @cart.save if current_user
    end
end
