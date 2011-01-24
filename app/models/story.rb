class Story < ActiveRecord::Base
  belongs_to :user
  has_many :sections
  has_many :chapters
end
