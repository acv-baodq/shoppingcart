class AddressesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_all_locate, except: [:new, :show]

  def index
  end

  def new
    @address = Address.new
  end

  def change_selected
    id = params[:id].to_s
    address = Address.find(id)
    address.selected = true

    begin
      Address.change_selected_address(id, current_user.id)
    rescue Exception => error
      render json: { message: 'Something went wrong...' }
    end
    render json: 200 if address.save
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    @address.selected = true
    if @address.save
      Address.change_selected_address(@address.id, current_user.id)
      @message =  { type: 'success', content: 'Create success'}
    else
      @message = { type: 'error', content: @address.errors.full_messages }
    end
    respond_to do |format|
      format.html { render plain: 'Not support'  }
      format.js
    end
  end

  def show
    render json: { data: Address.where(user_id: current_user.id) }
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      render :index, :@addresses => current_user.addresses, :format => :js
    end
    if @address.selected && current_user.addresses.count > 0
      Address.change_selected_address(current_user.id)
      current_user.addresses.first.update(selected: true)
    end
  end

  private
    def address_params
      params.require(:address).permit(:line1, :line2, :city, :state, :country_code, :state, :postal_code)
    end

    def get_all_locate
      @addresses =  Address.order(selected: :desc).locates(current_user.id)
    end
end
