class ApplicationsAddComment < ActiveRecord::Migration
  def up
    change_table :applications do |t|
      t.string :comment
    end
  end

  def down
  end
end
