class StorySection
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning


  field :title, type: String
  validates_presence_of :title
  field :title_format, type: String, default: "[title]"
  field :body, type: String
  field :include_in_toc, type: Boolean, default: true
  field :publication_date, type: TimeWithZone
  field :order, type: Integer
  validates_presence_of :order
  validates_uniqueness_of :order, :scope => :story

  has_one :next_section, :class_name => "StorySection", :inverse_of => :previous_section
  belongs_to :previous_section, :class_name => "StorySection", :inverse_of => :next_section

  belongs_to :story
  validates_presence_of :story

end