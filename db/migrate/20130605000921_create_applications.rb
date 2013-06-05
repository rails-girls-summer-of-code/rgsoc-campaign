class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :timestamp
      t.string :student_name
      t.string :student_email
      t.string :pair_name
      t.string :pair_email
      t.string :living_costs
      t.text   :data
      t.timestamps
    end

    add_index :applications, :timestamp
  end
end
