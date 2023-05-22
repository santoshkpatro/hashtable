class Admin::Organization::OrdersController < ApplicationController
  before_action :authenticate_user

  # GET /admin/organization/orders
  def index
    @orders = Order.where(organization_id: @current_organization_id, source: 'organization')
  end

  # GET /admin/organization/orders/:id/payment_initiate
  def payment_initiate
  end

  # POST /admin/organization/orders/:id/payment_confirm
  def payment_confirm
  end
end