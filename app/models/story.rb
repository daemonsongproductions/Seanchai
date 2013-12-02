class Story
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  validates_presence_of :title
  field :copyright, type: String
  field :license, type: String
  field :description, type: String
  field :publication_date, type: ActiveSupport::TimeWithZone, default: nil

  # Meta fields will store :name, :value and :display
  # TODO: Validate hash fields are correct: "validate :check_meta"
  field :meta, type: Hash

  # Access by: status_id = Status[:published].id
  field :status_id, type: Integer

  has_many :story_sections
  has_one :creator, :class_name => "User", :inverse_of => nil
  validates_presence_of :creator

  # TODO: Add ability for other users to be editors
  has_many :editors, :class_name => "User", :inverse_of => nil

  attr_accessor :creator

  def self.find_for_user(user)
    Story.or({created_by: user}, {editors: user})
  end

end