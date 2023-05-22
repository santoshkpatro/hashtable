class AddOrderRequiredInEnrollment < ActiveRecord::Migration[7.0]
  def change
    add_column  :enrollments, :order_required, :boolean, default: true
  end
end
