class User < ActiveRecord::Base
  belongs_to :role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  before_create :set_default_role

  private
  def set_default_role
    self.role ||= Role.find_by_name('reader')
  end

end
