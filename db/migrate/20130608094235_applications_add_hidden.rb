class ApplicationsAddHidden < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.boolean :hidden, default: false
    end
  end
end
