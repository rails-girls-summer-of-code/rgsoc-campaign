class Comment < ActiveRecord::Base
  belongs_to :application

  attr_accessible :application_id, :author_name, :text
end
