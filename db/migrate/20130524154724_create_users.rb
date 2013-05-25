class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.integer  :twitter_uid
      t.string   :twitter_handle
      t.integer  :github_uid
      t.string   :github_handle
      t.string   :homepage
      t.string   :description

      t.boolean  :display, :default => true
      t.boolean  :company, :default => true

      t.string   :stripe_plan
      t.string   :stripe_customer_id

      t.string   :encrypted_password
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
