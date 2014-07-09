class StorySection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Versioning
  include Mongoid::Orderable
  include Seanchai::StatusMethods


  field :title, type: String
  validates_presence_of :title
  slug :title, :scope => :story

  field :include_in_toc, type: Boolean, default: true
  field :publication_date, type: ActiveSupport::TimeWithZone

  # Access by: status_id = Status[:published].id
  field :status_id, type: Integer, default: Status.draft.id
  validates_inclusion_of :status_id, in: Status.find_all.map {|status| status.id }

  # Meta fields will store :name, :value and :display
  # TODO: Validate hash fields are correct: "validate :check_meta"
  field :meta, type: Hash

  field :body, type: String

  # Possibly make these functions, not fields.
  # has_one :next_section, :class_name => "StorySection", :inverse_of => :previous_section
  # belongs_to :previous_section, :class_name => "StorySection", :inverse_of => :next_section

  belongs_to :story
  validates_presence_of :story
  belongs_to :creator, class_name: "User", inverse_of: :created_story_sections
  # TODO: Order by this field; look up the docs
  orderable :scope => :story, :column => :order

  before_create :set_creator


  def initialize(attrs = nil)
    super
    self.story_id = Story.find(attrs[:story_id]).id if attrs[:story_id]
  end

  def self.find_visible_for(user, search_parameters = {})
    results = self.where(search_parameters).or([{status_id: Status.published.id}, {creator: user}])
    results
  end

  private

  def set_creator
    self.creator = self.story.creator
  end


end