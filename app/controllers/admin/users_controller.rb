class Admin::UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_organization, only: [:create, :destroy]

  def index
    @users = User.where(organization_id: @current_organization_id)
  end

  def create
    notify_user = params[:notify_user] || false
    
    password = params[:password]
    @user = User.new(user_params)
    @user.password = password
    @user.organization = @organization
    @user.save!
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :email, :role)
    end

    def set_organization
      @organization = Organization.find(@current_organization_id)
    end
end