class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string  :stripe_card_token
      t.string  :stripe_customer_id

      t.string  :package
      t.integer :amount
      t.string  :vat_id
      t.boolean :add_vat

      t.string  :name
      t.string  :email

      t.string  :address
      t.string  :zip
      t.string  :city
      t.string  :state
      t.string  :country

      t.string  :twitter_handle
      t.string  :github_handle
      t.string  :homepage

      t.boolean :display, :default => true

      t.timestamps null: true
    end
  end
end
