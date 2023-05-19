# == Schema Information
#
# Table name: enrollments
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  role            :string           default("student")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  course_id       :bigint           not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_enrollments_on_course_id                    (course_id)
#  index_enrollments_on_organization_id              (organization_id)
#  index_enrollments_on_organization_id_and_user_id  (organization_id,user_id) UNIQUE
#  index_enrollments_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
class Enrollment < ApplicationRecord
  belongs_to  :organization
  belongs_to  :user
  belongs_to  :course
end
