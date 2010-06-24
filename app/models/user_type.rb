class UserType < ActiveRecord::Base

  def self.author
    return UserType.find_by_name("author")
  end

  def self.reader
    return UserType.find_by_name("reader")
  end

end
