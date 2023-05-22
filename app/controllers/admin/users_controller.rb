class Admin::UsersController < ApplicationController
  before_action :authenticate_user

  # GET - /admin/users
  def index
    @users = User.where(organization_id: @current_organization_id).order(created_at: :desc).page(params[:page] || 1)
  end

  # POST - /admin/users
  def create
    notify_user = params[:notify_user] || false
    
    password = params[:password]
    @user = User.new(user_params)
    @user.password = password
    @user.organization_id = @current_organization_id
    @user.save!
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :email, :role)
    end
end