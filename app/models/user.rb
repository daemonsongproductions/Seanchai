class User < ActiveRecord::Base

  require 'digest/sha1'

  belongs_to :user_type

  HUMANIZED_COLUMN = {:confirmed_password => ""}

  validates_length_of :email, :within => 6..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :email, :password, :password_salt, :user_type
  validates_uniqueness_of :email

  attr_protected :id, :password_salt, :password, :user_type



  def save
    self.user_type = UserType.reader if self.user_type.nil?
    super  
  end

  def create_new_password
    new_password = generate_random_string
    self.password = new_password
    return new_password
  end

  def password=(password)
    @password_change_request = true
    self.password_salt = generate_random_string unless self.password_salt?
    super(User.encrypt_password(password, self.password_salt))
    @password_changed = false
  end

  def is_password?(password)
    self.password == User.encrypt_password(password, self.password_salt)
  end

  def for_atleast(user_type, &block)
    return unless block_given?
    block.call if user_type.user_level <= self.user_type.user_level
  end


  def self.encrypt_password(password, salt)
    Digest::SHA1.hexdigest(password + salt).to_s
  end

  def password_salt=(password_salt)
    raise "The password salt can only be changed as part of a password change." unless @password_change_request
    super password_salt
    @password_change_request = false
  end

  def self.human_attribute_name(attribute)
    HUMANIZED_COLUMN[attribute.to_sym] || super
  end

  private

  def generate_random_string(length = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    random_string = ""
    1.upto(length) { |i| random_string << chars[rand(chars.size-1)] }
    random_string
  end

end
