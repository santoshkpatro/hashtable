class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.references  :organization, null: false, foreign_key: true
      t.string      :email, null: false
      t.string      :full_name
      t.string      :password_digest
      t.string      :phone
      t.string      :role, default: 'admin'

      t.timestamps
    end

    add_index :users, [:organization_id, :email], unique: true
  end
end
