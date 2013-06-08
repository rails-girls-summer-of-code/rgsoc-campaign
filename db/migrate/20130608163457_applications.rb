class Applications < ActiveRecord::Migration
  def up
    change_table :applications do |t|
      t.string :project_name
    end
  end

  def down
  end
end
