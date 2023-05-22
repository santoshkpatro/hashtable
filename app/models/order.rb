# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  amount                  :decimal(10, 2)   not null
#  billed_enrollment_count :integer
#  billing_address         :json
#  billing_end_date        :datetime
#  billing_start_date      :datetime
#  course_details          :json
#  discount                :integer          default(0)
#  due_date                :datetime
#  paid                    :boolean          default(FALSE)
#  payment_gateway         :string
#  payment_status          :string           default("due")
#  price                   :decimal(10, 2)   not null
#  slug                    :string           not null
#  source                  :string           default("user")
#  status                  :string           default("initiated")
#  user_details            :json
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  course_id               :bigint
#  organization_id         :bigint           not null
#  payment_id              :string
#  user_id                 :bigint
#
# Indexes
#
#  index_orders_on_course_id        (course_id)
#  index_orders_on_organization_id  (organization_id)
#  index_orders_on_slug             (slug) UNIQUE
#  index_orders_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to  :organization
  belongs_to  :course, optional: true
  belongs_to  :user, optional: true

  before_create  :generate_order_slug

  private
    def generate_order_slug
      self.slug = "order_#{SecureRandom.hex(10)}"
    end
end
