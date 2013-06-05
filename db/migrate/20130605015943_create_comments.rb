class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :application
      t.string :author_name
      t.text :text

      t.timestamps
    end
  end
end
