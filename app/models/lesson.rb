# == Schema Information
#
# Table name: lessons
#
#  id              :bigint           not null, primary key
#  description     :text
#  position        :integer          default(1)
#  status          :string           default("draft")
#  title           :string           not null
#  type            :string           default("video")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  chapter_id      :bigint
#  course_id       :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_lessons_on_chapter_id            (chapter_id)
#  index_lessons_on_chapter_id_and_title  (chapter_id,title) UNIQUE
#  index_lessons_on_course_id             (course_id)
#  index_lessons_on_organization_id       (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class Lesson < ApplicationRecord
  belongs_to  :organization
  belongs_to  :course
  belongs_to  :chapter
end
