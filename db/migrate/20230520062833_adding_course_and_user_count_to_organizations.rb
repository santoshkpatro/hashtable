class AddingCourseAndUserCountToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column  :organizations, :courses_count, :integer, default: 0
    add_column  :organizations, :users_count, :integer, default: 0
  end
end
