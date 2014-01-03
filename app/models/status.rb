class Status
  attr_accessor :id, :name

  def initialize(options = {})
    options = options.symbolize_keys
    @id, @name = options[:id], options[:name]
  end

  def symbol
    @name.to_s.downcase.intern
  end

  def self.[](value)
    @@statuses.find { |status| status.symbol == value.to_s.downcase.intern }
  end

  def self.find(id)
    @@statuses.find { |status| status.id.to_s == id.to_s }
  end

  def self.find_all
    @@statuses.dup
  end

  def self.selectable
    find_all - [self['Scheduled']]
  end

  def self.selectable_values
    self.selectable.map(&:name)
  end

  def self.draft
    self[:draft]
  end

  def self.private
    self[:private]
  end

  def self.published
    self[:published]
  end

  @@statuses = [
    Status.new(:id => 1,  :name => 'Draft'    ),
    Status.new(:id => 2,  :name => 'Scheduled'),
    Status.new(:id => 3,  :name => 'Private'   ),
    Status.new(:id => 4,  :name => 'Published')

  ]

end