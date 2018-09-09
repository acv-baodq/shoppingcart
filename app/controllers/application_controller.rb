class ApplicationController < ActionController::Base
  before_action :guest_user # test for guest user, add devise later

  private
    def guest_user
      if current_user
        @cart = Cart.find_or_create_by(user_id: current_user.id)
        if session[:cart].present?
          session[:cart]['data'].each_key do |key|
            if @cart.data.has_key? key
              @cart.data[key]['quantity'] = (@cart.data[key]['quantity'].to_i + session[:cart]['data'][key]['quantity'].to_i).to_s
            else
              @cart.data[key] = session[:cart]['data'][key]
            end
          end
          @cart.save
          session[:cart] = nil
        end
        return
      end
      session[:cart] ||= {}
      session[:cart]['data'] = {} if session[:cart].empty?
      @cart = session[:cart]
    end

    def total_price
      total_price = 0
      @cart['data'].each do |key, val|
        total_price += ( val['quantity'].to_i * val['price'].to_f )
      end
      @cart['total_price'] = total_price
    end
end
