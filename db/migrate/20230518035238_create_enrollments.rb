class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references  :organization, null: false, foreign_key: true
      t.references  :course, null: false, foreign_key: true
      t.references  :user, null: false, foreign_key: true
      t.string      :role, default: 'student'
      t.boolean     :active, default: true
      t.datetime    :enrolled_on
      t.datetime    :valid_till

      t.timestamps
    end

    add_index :enrollments, [:organization_id, :user_id], unique: true
  end
end
