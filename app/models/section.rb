class Section < ActiveRecord::Base
  belongs_to :story
  belongs_to :section_type
  has_many :chapters
end
