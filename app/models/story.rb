class Story
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  validates_presence_of :title
  field :copyright, type: String
  field :license, type: String
  field :description, type: String
  field :publication_date, type: ActiveSupport::TimeWithZone, default: nil
  field :meta, type: Hash
  # TODO: Status field

  has_many :story_sections
  has_one :creator, :class_name => "User", :inverse_of => nil
  validates_presence_of :creator
  has_many :editors, :class_name => "User", :inverse_of => nil

  attr_accessor :creator

  def self.new(params)

  end

  def self.find_for_user(user)
    Story.or({created_by: user}, {editors: user})
  end

end