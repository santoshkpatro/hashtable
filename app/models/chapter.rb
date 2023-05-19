# == Schema Information
#
# Table name: chapters
#
#  id              :bigint           not null, primary key
#  description     :text
#  position        :integer          default(1)
#  status          :string           default("draft")
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  course_id       :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_chapters_on_course_id            (course_id)
#  index_chapters_on_course_id_and_title  (course_id,title) UNIQUE
#  index_chapters_on_organization_id      (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class Chapter < ApplicationRecord
  belongs_to  :organization
  belongs_to  :course

  has_many  :lessons
end
