class ApplicationsAddSponsorPick < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.string :sponsor_pick
    end
  end
end
