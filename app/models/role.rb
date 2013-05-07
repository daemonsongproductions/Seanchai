class Role
  include Mongoid::Document
  embedded_in :user
end