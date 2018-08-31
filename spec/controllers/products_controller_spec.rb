require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let (:category) { create(:category) }
  let (:product) { create(:product) }

  context '#index page' do
    it 'should get all product' do
      data = create_list(:product, 10)
      get :index
      expect(assigns(:products)).to eq data
    end
  end

  context '#show page' do
    it 'assign to @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end
  end
end
