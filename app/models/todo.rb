class Todo < ActiveRecord::Base
  attr_accessible :id, :content, :done, :created_at, :updated_at
end
