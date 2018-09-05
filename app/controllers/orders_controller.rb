class OrdersController < ApplicationController
  def index
    @locates = Address.locates(current_user.id)
  end

  def create
  end
end
