class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string  :name, null: false
      t.string  :slug, null: false
      t.string  :status, default: 'active'
      t.text    :description
      
      # SOFT DELETE
      t.datetime  :deleted_at
      t.timestamps
    end

    add_index :organizations, :slug, unique: true
  end
end
