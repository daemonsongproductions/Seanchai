class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :username,           :type => String, :default => ""
  validates_presence_of :username
  validates_presence_of :email
  validates_uniqueness_of :username, :case_sensitive => true
  field :name,               :type => String, :default => ""
  field :email,              :type => String, :default => ""

  field :encrypted_password, :type => String, :default => ""

  field :guest_user, :type => Boolean, :default => false
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  embeds_one :role, class_name: "Role", inverse_of: nil
  validates_presence_of :role

  has_many :created_stories, class_name: "Story", inverse_of: :creator
  has_many :created_story_sections, class_name: "StorySection", inverse_of: :creator

  index({username: 1}, {unique: true})

  def self.find_by_username(username)
    self.find_by(username: username)
  end

  def self.guest_user

    guest = User.create(name: "guest",
                        email: "guest_#{Time.now.to_i}#{rand(99)}@example.com",
                        guest_user: true, role: Guest.new
    )
    guest.save!(:validate => false)
    guest
  end

  def selected_role=(value)
    Rails.logger.error("EYES WITHOUT A FACE")
    if value == 'creator'
      self.role = Creator.new
    elsif value == 'reader'
      self.role = Reader.new
    end
  end

  def email_required?
    false
  end

  def permissions
    role.permissions_for(self)
  end


end
