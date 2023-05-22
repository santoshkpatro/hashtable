# == Schema Information
#
# Table name: enrollments
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(TRUE)
#  enrolled_on     :datetime
#  order_required  :boolean          default(TRUE)
#  role            :string           default("student")
#  valid_till      :datetime
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

  after_create  :create_or_update_order

  private
    def create_or_update_order
      return if !self.order_required

      order = Order.find_by(
                organization: self.organization, 
                billing_start_date: Time.now.at_beginning_of_month, 
                billing_end_date: Time.now.at_end_of_month, 
                source: 'organization'
              )

      if order.nil?        
        order = Order.create!(
          organization: self.organization, 
          billing_start_date: Time.now.at_beginning_of_month, 
          billing_end_date: Time.now.at_end_of_month, 
          source: 'organization',
          price: 0,
          amount: 0,
          status: 'created',
          payment_status: 'due',
          billed_enrollment_count: 0,
          due_date: Time.now.at_beginning_of_month.next_month + 10.days
        )
      end

      # Update the enrollment count and price
      order.billed_enrollment_count += 1
      order.price += 30
      order.amount += 30
      order.save!
    end
end
