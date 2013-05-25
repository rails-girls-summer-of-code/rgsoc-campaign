class Address < ActiveRecord::Base
  attr_accessible :name, :street, :zip, :city, :state, :country

  def empty?
    attributes.slice(%w(street zip city)).values.compact.empty?
  end
end

