class AuthController < ApplicationController
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
      @organization = Organization.create!(name: name, slug: name.parameterize)
      @user = User.new(register_params)
      @user.organization = @organization
      @user.role = "owner"
      @user.save!
    end
  end

  private
    def register_params
      params.require(:auth).permit(:email, :full_name, :password)
    end
end