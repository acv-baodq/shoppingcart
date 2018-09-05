class AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    @address.save
    @locates = Address.where(user_id: current_user.id)
  end

  private
    def address_params
      params.require(:address).permit(:line1, :line2, :city, :state, :country_code, :state, :postal_code)
    end
end
