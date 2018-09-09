class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action :save_to_current_user, :total_price, except: [:show]

  def index
    render json: {data: @cart['data']}
  end

  def update
    product = Product.find(params[:id].to_i)
    if(@cart['data'].key? product.id.to_s)
      @cart['data'][product.id.to_s]['quantity'] = (@cart['data'][product.id.to_s]['quantity'].to_i + 1).to_s
      return render json: {data: @cart['data'][product.id.to_s], messages: "Added #{product.name} x#{@cart['data'][product.id.to_s]['quantity']}" }
    else
      data_build = product.attributes.except('created_at', 'updated_at', 'category_id')
      data_build['quantity'] = '1'
    end
    @cart['data'][product.id.to_s] = data_build
    render json: {data: data_build, messages: "Added #{product.name} success" }
  end

  def show
    render json: { data: @cart['data'] }
  end

  def destroy
    product = Product.find(params[:id].to_i)
    @cart['data'].delete(product.id.to_s)
    render json: { messages: "Delete #{product.name} success" }
  end

  def create
    data = params[:data].present? ? params[:data] : {}
    data.each do |key, val|
      if val == '0'
        @cart['data'].delete(key)
        next
      end
      @cart['data'][key]['quantity'] = val
    end
    render json: {data: @cart, messages: "Saved all changes" }
  end

  private
    def save_to_current_user
      @cart.save if current_user
    end
end
