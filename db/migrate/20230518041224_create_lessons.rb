class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.references  :organization, null: false, foreign_key: true
      t.references  :course, null: false, foreign_key: true
      t.references  :chapter, foreign_key: true

      t.string      :title, null: false
      t.string      :status, default: 'draft'
      t.integer     :position, default: 1
      t.text        :description
      t.string      :type, default: 'video'

      t.timestamps
    end

    add_index :lessons, [:chapter_id, :title], unique: true
  end
end
