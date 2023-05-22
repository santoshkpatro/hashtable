class Admin::OrdersController < ApplicationController
  before_action :authenticate_user

  # GET - /admin/orders
  def index
  end
end