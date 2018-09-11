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
      Address.change_selected_address(current_user.id)
    rescue Exception => error
      render json: { message: 'Something went wrong...' }
    end
    render json: 200 if address.save
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    @address.selected = true
    Address.change_selected_address(current_user.id)
    @message = @address.save ? 'Create success' : @address.errors.full_messages
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
  end

  def show
    render json: { data: Address.where(user_id: current_user.id) }
  end

  private
    def address_params
      params.require(:address).permit(:line1, :line2, :city, :state, :country_code, :state, :postal_code)
    end

    def get_all_locate
      @addresses =  Address.locates(current_user.id)
    end
end
