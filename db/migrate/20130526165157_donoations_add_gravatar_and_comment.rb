class DonoationsAddGravatarAndComment < ActiveRecord::Migration
  def change
    add_column :donations, :comment, :text
    add_column :donations, :gravatar_url, :string
  end
end
