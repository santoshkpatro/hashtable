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

  enum role: {
    admin: 'admin',
    student: 'student',
    instructor: 'instructor',
    owner: 'owner'
  }, _prefix: true
end
