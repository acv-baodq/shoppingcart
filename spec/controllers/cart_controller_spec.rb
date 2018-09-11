require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let (:cart) { create(:cart) }
  let (:product) { create(:product) }
  before(:each) do
    session[:cart] ||= {'data': {}, 'total_price': 0 }
    session[:cart]['data'] = cart.data
  end

  describe 'Guest User' do
    context '#index' do
      it 'render cart' do
        get :index
        expect(JSON.parse(response.body)['data']).to eq session[:cart]['data']
      end
    end

    context '#create' do
      it 'params = 0' do
        put :update, params: { id: product.id }
        post :create, params: { data: { "#{product.id}": '0'} }
        expect(JSON.parse(response.body)['data']['data'][product.id.to_s]).to eq nil
      end

      it 'pramn != 0' do
        put :update, params: { id: product.id }
        post :create, params: { data: { "#{product.id}": '3'} }
        expect(JSON.parse(response.body)['data']['data'][product.id.to_s]['quantity'].to_i).to eq 3
      end
    end

    context '#update' do
      it 'new item' do
        size = session[:cart]['data'].length
        put :update, params: { id: product.id }
        expect(session[:cart]['data'].length).to eq(size + 1)
        expect(JSON.parse(response.body)["messages"]).to eq "Added #{product.name} success"
      end

      it 'exist item in cart' do
        put :update, params: { id: product.id }
        quantity = session[:cart]['data'][product.id.to_s]['quantity'].to_i
        put :update, params: { id: product.id }
        expect(session[:cart]['data'][product.id.to_s]['quantity'].to_i).to eq(quantity + 1)
        expect(JSON.parse(response.body)["messages"]).to eq "Added #{product.name} x#{quantity + 1}"
      end
    end

    context '#delete' do
      it 'delete success' do
        put :update, params: { id: product.id }
        size = session[:cart]['data'].length
        delete :destroy, params: { id: product.id }
        expect(session[:cart]['data'].length).to eq(size - 1)
      end
    end
  end

  describe 'User signed in' do
    let(:user) { create(:user) }
    let(:cart_2) { create(:cart, user_id: user.id) }
    context 'should merge data with session' do
      it 'user cart empty' do
        sign_in user
        get :index
        expect(JSON.parse(response.body)['data']).to eq user.cart.data
      end

      it 'user cart not empty' do
        sign_in user
        get :index
        # cart is session
        expect(cart.data).to eq user.cart.data
      end
    end
  end
end
