# == Schema Information
#
# Table name: courses
#
#  id              :bigint           not null, primary key
#  currency        :string
#  description     :text
#  price           :decimal(10, 2)   default(0.0)
#  slug            :string           not null
#  status          :string           default("draft")
#  title           :string           not null
#  validity        :integer          default(365)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_courses_on_organization_id           (organization_id)
#  index_courses_on_organization_id_and_slug  (organization_id,slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Course < ApplicationRecord
  belongs_to  :organization

  has_many    :enrollments, dependent: :destroy
  has_many    :chapters, dependent: :destroy
  has_many    :lessons, dependent: :destroy
  has_many    :orders

  after_create :increment_courses_count_in_organization
  
  after_destroy :decrement_courses_count_in_organization

  private
    def increment_courses_count_in_organization
      self.organization.courses_count += 1
      self.organization.save!
    end

    def decrement_courses_count_in_organization
      self.organization.courses_count -= 1
      self.organization.save!
    end
end
