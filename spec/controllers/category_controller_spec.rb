require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let (:category) { create(:category) }

  context '#index page' do
    it 'should get all category' do
      data = create_list(:category, 10)
      get :index
      expect(assigns(:categories)).to eq data
    end
  end

  context '#show page' do
    it 'assign to @category' do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq category
    end
    it 'find all relate product and assign to @products' do
      get :show, params: { id: category.id }
      products = category.products
      expect(assigns(:products)).to eq products
    end
  end
end
