class Application < ActiveRecord::Base
  attr_accessible :timestamp, :data

  serialize :data

  has_many :comments

  def filtered_data
    data.dup.delete_if { |key, value| key =~ /Student/ }
  end
end
