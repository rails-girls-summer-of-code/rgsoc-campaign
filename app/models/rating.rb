class Rating < ActiveRecord::Base
  class << self
    def user_names
      connection.select_values('SELECT DISTINCT user_name FROM RATINGS ORDER BY user_name')
    end
  end

  attr_accessible :application_id, :user_name, :data

  serialize :data

  belongs_to :application

  def data
    Hashr.new(super)
  end

  def value
    data.values.sum
  end
end
