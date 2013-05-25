class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :user

      t.string  :stripe_token
      t.string  :stripe_id

      t.string  :package
      t.integer :amount
      t.boolean :subscription, null: false, default: false
      t.text    :comment
      t.text    :message
      t.string  :vat_id
      t.boolean :add_vat

      t.boolean :active, null: false, default: true
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
