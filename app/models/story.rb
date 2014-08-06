class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Seanchai::StatusMethods

  field :title, type: String
  validates_presence_of :title
  slug :title
  field :copyright, type: String
  field :license, type: String
  field :description, type: String
  field :publication_date, type: ActiveSupport::TimeWithZone, default: nil

  # Meta fields will store :name, :value and :display
  # TODO: Validate hash fields are correct: "validate :check_meta"
  field :meta, type: Hash

  # Access by: status_id = Status[:published].id
  field :status_id, type: Integer, default: Status[:draft].id
  validates_inclusion_of :status_id, in: Status.find_all.map {|status| status.id }

  has_many :story_sections, order: :order.asc
  belongs_to :creator, class_name: "User", inverse_of: :created_stories
  validates_presence_of :creator

  # TODO: Add ability for other users to be editors
  #belongs_to :editors, :class_name => "User"

  def self.find_for_user(user)
    Story.or({creator: user}, {editors: user})
  end

  def self.find_visible_for(user, search_parameters = {})

    results = self.where(search_parameters[:criteria]).
        or([{status_id: Status[:published].id}, {creator: user}]).
        order_by(search_parameters[:meta][:order_by]).
        limit(search_parameters[:meta][:limit])
    results if results.count > 0
  end

end