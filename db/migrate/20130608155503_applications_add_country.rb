class ApplicationsAddCountry < ActiveRecord::Migration
  def up
    change_table :applications do |t|
      t.string :country
      t.integer :min_living
      t.integer :project_visibility
    end
  end

  def down
    remove_column :applications, :country
    remove_column :applications, :min_living
    remove_column :applications, :project_visibility
  end
end
