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
  # TODO: Order by this field; look up the docs
  orderable :scope => :story, :column => :order


  def initialize(attrs = nil, options = nil)
    super
    self.story_id = Story.find(attrs[:story_id]).id if attrs[:story_id]
  end

  def creator
    self.story.creator
  end


end