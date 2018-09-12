require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let (:user) { create(:user) }
  let (:address) { create(:address, user_id: user.id) }
  let (:address_2) { create(:address, user_id: user.id) }
  let (:address_build) { attributes_for(:address) }


  context '#create address' do
    before { controller.instance_variable_set(:@current_user, user) }
    it 'create success' do
      expect{
        post :create, params: { address: address_build }
      }.to change {Address.count}.by(1)
    end
  end

  context '#change_selected' do
    before { controller.instance_variable_set(:@current_user, user) }
    it 'success' do
      post :change_selected, params: { id: address_2.id }
      expect(Address.find(address_2.id).selected).to be true
    end
  end



end
