class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.references  :organization, null: false, foreign_key: true
      t.references  :course, null: false, foreign_key: true
      t.string      :title, null: false
      t.string      :status, default: 'draft'
      t.integer     :position, default: 1
      t.text        :description

      t.timestamps
    end

    add_index :chapters, [:course_id, :title], unique: true
  end
end
