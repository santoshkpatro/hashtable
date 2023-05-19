class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.references  :organization, null: false, foreign_key: true
      t.string      :title, null: false
      t.string      :slug, null: false
      t.text        :description
      t.string      :status, default: 'draft'
      t.string      :currency
      t.decimal     :price, precision: 10, scale: 2, default: 0
      
      t.timestamps
    end

    add_index :courses, [:organization_id, :slug], unique: true
  end
end
