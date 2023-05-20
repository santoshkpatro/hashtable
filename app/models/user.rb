# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  full_name       :string
#  password_digest :string
#  phone           :string
#  role            :string           default("admin")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_users_on_organization_id            (organization_id)
#  index_users_on_organization_id_and_email  (organization_id,email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class User < ApplicationRecord
  has_secure_password

  belongs_to  :organization

  has_many  :orders

  after_create :increment_users_count_in_organization
  
  after_destroy :decrement_users_count_in_organization

  enum role: {
    admin: 'admin',
    student: 'student',
    instructor: 'instructor',
    owner: 'owner'
  }, _prefix: true

  def generate_jwt_token
    jwt_secret = Rails.application.secrets.secret_key_base
    payload = {
      user_id: self.id,
      organization_id: self.organization_id,
      role: self.role,
      exp: (Time.now + 7.days).to_i
    }

    JWT.encode payload, jwt_secret, 'HS256'
  end

  def self.decode_jwt_token(token)
    jwt_secret = Rails.application.secrets.secret_key_base

    begin
      decoded_token = JWT.decode token, jwt_secret, true, { algorithm: 'HS256' }
    rescue JWT::ExpiredSignature
      raise "Token has been expired"
    rescue JWT::JWKError
      raise "Unable to decode token"
    end

    decoded_token[0]
  end

  private
    def increment_users_count_in_organization
      self.organization.users_count += 1
      self.organization.save!
    end

    def decrement_users_count_in_organization
      self.organization.users_count -= 1
      self.organization.save!
    end
end
