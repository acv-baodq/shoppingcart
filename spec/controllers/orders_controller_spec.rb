require 'rails_helper'
require 'paypal-sdk-rest'

RSpec.describe OrdersController, type: :controller do
  let (:cart) { create(:cart) }
  let (:user) { create(:user, cart: cart) }
  let(:addresses) { create_list(:address, 10) }
  context 'create payment' do
    before {
      sign_in user
      controller.instance_variable_set(:@current_user, user)
    }

    it 'create success' do
      old_size = user.orders.size
      post :create
      expect(JSON.parse(response.body)['status']).to eq 'OK'
    end

    it 'create failed' do
      user.cart = nil
      user.save
      post :create
      expect(JSON.parse(response.body)['status']).to eq 'FAILED'
    end
  end
end
