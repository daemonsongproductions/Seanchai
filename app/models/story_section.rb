class StorySection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Versioning
  include Seanchai::StatusMethods


  field :title, type: String
  validates_presence_of :title
  slug :title, :scope => :story

  field :include_in_toc, type: Boolean, default: true
  field :publication_date, type: ActiveSupport::TimeWithZone

  # TODO: Order by this field; look up the docs
  field :order, type: Integer
  validates_presence_of :order
  validates_uniqueness_of :order, :scope => :story

  # Access by: status_id = Status[:published].id
  field :status_id, type: Integer, default: Status.draft
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

end