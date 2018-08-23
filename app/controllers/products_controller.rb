class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.page params[:page]
  end

  def show
  end

  private
    def product_params
      params.require(:product).permit( :title, :desciption, :category_id, :price)
    end

    def get_product
      @product = Product.find(params[:id])
    end
end
