class AuthController < ApplicationController
  before_action :authenticate_user, only: [:profile]

  def login
    return render json: { message: 'ok' }, status: :ok
  end

  def register
    existing_account = User.find_by(email: register_params[:email], role: 'owner')
    if existing_account.present?
      return render json: { message: 'Account exists with the given email address' }, status: :forbidden
    end

    ActiveRecord::Base.transaction do
      name = "#{register_params[:full_name]}'s Org"
      @organization = Organization.create!(name: name, slug: name.parameterize, status: "active")
      @user = User.new(register_params)
      @user.organization = @organization
      @user.role = User.roles[:owner]
      @user.save!
    end
  end

  def profile
    puts @current_organization_id
  end

  private
    def register_params
      params.require(:auth).permit(:email, :full_name, :password)
    end
end