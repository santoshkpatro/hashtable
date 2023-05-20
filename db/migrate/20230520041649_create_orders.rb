class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references  :organization, foreign_key: true
      t.references  :course, foreign_key: true
      t.references  :user, foreign_key: true
      t.string      :slug, null: false
      t.string      :source, default: 'user'
      t.integer     :price, null: false
      t.integer     :discount, default: 0
      t.integer     :amount, null: false
      t.string      :status, default: 'initiated'
      t.string      :payment_status, default: 'due'
      t.string      :payment_id
      t.string      :payment_gateway
      t.boolean     :paid, default: false
      t.integer     :billed_enrollment_count
      t.datetime    :billing_start_date
      t.datetime    :billing_end_date
      t.datetime    :due_date
      t.json        :billing_address
      t.json        :user_details
      t.json        :course_details

      t.timestamps
    end

    add_index :orders, :slug, unique: true
  end
end
