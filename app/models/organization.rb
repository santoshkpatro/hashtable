# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  courses_count :integer          default(0)
#  deleted_at    :datetime
#  description   :text
#  name          :string           not null
#  slug          :string           not null
#  status        :string           default("active")
#  users_count   :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organizations_on_slug  (slug) UNIQUE
#
class Organization < ApplicationRecord
  has_many  :users, dependent: :destroy
  has_many  :courses, dependent: :destroy
  has_many  :enrollments, dependent: :destroy
  has_many  :chapters, dependent: :destroy
  has_many  :lessons, dependent: :destroy
  has_many  :orders

  default_scope { where(deleted_at: nil) }
end
