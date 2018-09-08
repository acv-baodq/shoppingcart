class AddressesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_all_locate, except: [:new, :show]

  def index
    # render json: {data: Address.locates(current_user.id)}
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    return @message = 'Create success' if @address.save
    @message = @address.errors.full_messages
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
