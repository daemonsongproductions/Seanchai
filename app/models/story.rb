class Story
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  validates_presence_of :title
  field :copyright, type: String
  field :description, type: String
  field :publication_date, type: TimeWithZone

  has_many :story_sections
  has_one :created_by, :class_name => "User", :inverse => nil
  has_many :editors, :class_name => "User", :inverse => nil

  def self.find_for_user(user)
    Story.or({created_by: user}, {editors: user})
  end

end